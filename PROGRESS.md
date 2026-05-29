# WallpaperApp Development Progress

## v0.1.0 — Initial Release ✓

### Completed
- [x] Reference implementations studied (aerial, wallpaper-player-mac)
- [x] Xcode project scaffold (Swift 6.0, macOS 13+)
- [x] AppDelegate + main.swift entry point (@MainActor isolated)
- [x] WallpaperWindow.swift — desktop-level NSWindow per screen
  - Position: kCGDesktopWindowLevel - 1 (below desktop icons)
  - collectionBehavior: .canJoinAllSpaces + .stationary (Space persistence)
  - AVPlayerLayer for hardware-accelerated video
- [x] PlayerManager.swift — AVQueuePlayer + AVPlayerLooper
  - Seamless looping via AVPlayerLooper
  - Pause/resume control
  - @Published @ObservableObject for SwiftUI binding
- [x] PowerMonitor.swift — battery state, screen sleep detection
  - pmset monitoring for battery level < 20%
  - NSWorkspace.screensDidSleep/Wake notifications
  - Auto-pause on low battery or sleep
- [x] MenuBarController.swift — NSStatusItem + SwiftUI popover
  - Menu bar icon (play.circle.fill)
  - Popover-based UI
- [x] ContentView.swift — SwiftUI popover UI
  - Play/pause toggle
  - File picker for MP4 import
  - Current video display
- [x] Build successful (Swift 6.0, macOS 13+)
- [x] App runtime test (process running, no crashes)
- [x] DMG distribution created (WallpaperApp-0.1.0.dmg, 61KB)
- [x] Ad-hoc code signing
- [x] Tagged v0.1.0

### Next Steps (v0.2+)
- [ ] Test with real MP4 files (currently /tmp/test.mp4)
- [ ] File persistence (UserDefaults or plist for chosen wallpapers)
- [ ] Per-screen wallpaper selection (currently single player)
- [ ] Launch agent for login auto-start (~/Library/LaunchAgents)
- [ ] Apple notarization (post-ship)
- [ ] Homebrew Cask distribution
- [ ] Fullscreen app detection (pause during fullscreen)

### Architecture Notes
- Single monolith app (no daemon for v1)
- All UI runs on MainActor for AppKit safety
- Looper-based seamless video looping (AVPlayerLooper > manual loop)
- Per-screen window instances for multi-monitor support
- Battery/sleep monitoring via NotificationCenter
- Content-agnostic: load any MP4 URL

### Known Limitations
- Only one video URL at a time (per PlayerManager)
- No video library or catalog (local files only)
- DMG unsigned (requires right-click → Open on first launch)
- Menu bar popover triggers on icon click (no persistent window)

### File Structure
```
WallpaperApp.app/
├── Contents/
│   ├── MacOS/
│   │   └── WallpaperApp (binary)
│   ├── Info.plist (bundle metadata)
│   ├── Resources/
│   │   └── CLAUDE.md
│   └── WallpaperApp.entitlements (no sandbox)
```

### Session Summary (2026-05-29)
Studied reference implementations, scaffolded Xcode project, built all core components, tested app runtime, created DMG distribution, tagged v0.1.0 release.
