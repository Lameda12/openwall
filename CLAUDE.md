# CLAUDE.md — macOS Live Wallpaper App

## Project
Open-source live wallpaper app for macOS. Working name: TBD.
Target: feature parity with wallspace.app — 4K video behind desktop icons, <2% CPU,
multi-monitor, custom MP4 import, battery-aware pause, menu bar control.
Distribution: DMG via GitHub Releases + Homebrew Cask.

## Architecture Decision (locked)
Monolith Swift app. No IPC daemon on v1.
Module separation inside a single .app:
- WallpaperWindow.swift   — NSWindow at kCGDesktopWindowLevel, per-screen instances
- PlayerManager.swift     — AVPlayer + AVPlayerLayer, looping, pause/resume
- PowerMonitor.swift      — battery state, fullscreen detection, triggers pause
- MenuBarController.swift — NSStatusItem, SwiftUI popover host
- ContentView.swift       — SwiftUI: wallpaper grid, file picker, active state

Reference implementation studied before writing code:
- haren724/wallpaper-player-mac (NSWindow + AVPlayerLayer setup)
- aerialscreensaver/aerial (mature production architecture)

## macOS-Specific Constraints
- Requires macOS 13 Ventura+ (AVPlayerLayer + NSWindow desktop level stable)
- kCGDesktopWindowLevel or NSWindow.Level(rawValue: kCGDesktopWindowLevel)
- Entitlements needed: no sandbox for desktop-level windows (outside App Store)
- Code signing: ad-hoc for open source GitHub distribution (avoids $99/yr for v1)
  Notarization deferred until v1 ships and has users
- LaunchAgent plist for login persistence — defer to v1.1

## Tech Stack
- Language: Swift 5.9+
- UI: SwiftUI (menu bar popover only — not full window)
- Video: AVFoundation + AVKit (AVPlayer, AVPlayerLayer, AVPlayerLooper)
- Window: AppKit (NSWindow, NSScreen, NSStatusItem)
- Build: Xcode, no SPM dependencies for core (keep it clean)
- Distribution: xcodebuild archive → DMG via create-dmg or Packages.app

## Performance Targets
- CPU: <2% during 4K playback (hardware-accelerated via AVPlayerLayer)
- RAM: <80MB for 4K video
- Startup: <1s to first frame
- Auto-pause: when on battery AND battery < 20%, when fullscreen app active

## File Naming & Structure
WallpaperApp/
  AppDelegate.swift
  WallpaperWindow.swift
  PlayerManager.swift
  PowerMonitor.swift
  MenuBarController.swift
  ContentView.swift       (SwiftUI popover)
  Assets.xcassets
  Info.plist
  WallpaperApp.entitlements

## Build & Run
- `xcodebuild -scheme WallpaperApp -configuration Debug build`
- Target: macOS 13+, arm64 + x86_64 (universal binary)

## Claude Code Patterns
- When writing Swift: functional where clean, avoid Combine complexity on v1
- AVPlayerLooper > manual NotificationCenter loop for seamless video looping
- NSScreen.screens for multi-monitor: one WallpaperWindow instance per screen
- Use `@Published` + `ObservableObject` for PlayerManager state → SwiftUI
- No storyboards, no XIBs — pure code layout

## Known Gotchas
- NSWindow at desktop level: must set `collectionBehavior` to
  `.canJoinAllSpaces` and `.stationary` or it will hide on Space switch
- AVPlayerLayer frame must match NSWindow contentView bounds exactly
- Gatekeeper: unsigned DMG requires user to right-click → Open on first launch
  — add this to README, not an error
- Screen sleep: register for NSWorkspace.willSleepNotification to pause

## What's Out of Scope for v1
- Content library / wallpaper catalog (local files only)
- Homebrew Cask (post-ship)
- Apple notarization (post-ship)
- XPC daemon extraction (v2 if CLI demand exists)
- Lock screen wallpapers (requires macOS 26+)

## Session Workflow
1. git init → initial commit before any feature code
2. Read reference repos before writing WallpaperWindow.swift
3. Commit per component: `feat(window): desktop-level NSWindow with AVPlayerLayer`
4. PROGRESS.md updated at end of each session
5. Tag v0.1.0 when DMG produces a working binary
