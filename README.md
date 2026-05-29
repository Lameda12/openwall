# openwall — macOS Live Wallpaper

Lightweight open-source live wallpaper app for macOS. Play MP4 videos behind desktop icons with <2% CPU usage.

## Features

- 4K video playback behind desktop icons
- Multi-monitor support (one video per screen)
- Custom MP4 import
- Battery-aware pause (pauses on battery < 20%)
- Fullscreen detection (pauses during fullscreen apps)
- Remembers last chosen video across restarts
- Menu bar control
- <2% CPU, <80MB RAM per 4K video

## Installation

1. Download `openwall-0.1.0.dmg` from [Releases](https://github.com/Lameda12/openwall/releases)
2. Open the DMG and drag **openwall.app** to Applications
3. **Right-click → Open** on first launch (required — app is unsigned)
4. Click "Open" in the Gatekeeper dialog that appears

> If you see "WallpaperApp Not Opened" and only a **Done** button (no Open option), run this once in Terminal:
> ```bash
> xattr -cr /Applications/WallpaperApp.app
> ```
> Then double-click the app normally.

## Login auto-start (optional)

```bash
cp LaunchAgent/com.openwall.live.plist ~/Library/LaunchAgents/
launchctl load ~/Library/LaunchAgents/com.openwall.live.plist
```

## Build & Run

```bash
swift build -c release
```

Requires macOS 13+ (Ventura or later).

## Development

See [CLAUDE.md](CLAUDE.md) for architecture and design decisions.

## License

MIT
