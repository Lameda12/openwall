# WallpaperApp Development Progress

## v0.1.0 — Initial Build

### Completed
- [x] Xcode project scaffold (Swift Package Manager)
- [x] AppDelegate + main.swift entry point
- [x] WallpaperWindow.swift — desktop-level NSWindow per screen
- [x] PlayerManager.swift — AVQueuePlayer + AVPlayerLooper
- [x] PowerMonitor.swift — battery state, screen sleep detection
- [x] MenuBarController.swift — NSStatusItem + SwiftUI popover
- [x] ContentView.swift — SwiftUI UI for popover
- [x] Initial build successful (no errors)

### In Progress
- [ ] Test wallpaper window visibility
- [ ] Test video playback via URL
- [ ] Test menu bar interaction
- [ ] Create DMG distribution
- [ ] Ad-hoc code signing

### Architecture Notes
- Single monolith app (no daemon)
- All UI runs on MainActor for AppKit safety
- Looper-based seamless video looping (AVPlayerLooper)
- Per-screen window instances for multi-monitor
- Battery/sleep monitoring via NotificationCenter

### Known Gaps (v0.2+)
- No file persistence (chosen wallpapers)
- No launch agent for login auto-start
- No Apple notarization
- No Homebrew Cask

### Session Summary (2026-05-29)
Reference implementations studied, project scaffolded, all core components built, initial build passing.
