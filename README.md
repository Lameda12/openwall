# WallpaperApp — macOS Live Wallpaper

Lightweight open-source live wallpaper app for macOS. Play MP4 videos behind desktop icons with <2% CPU usage.

## Features

- 4K video playback behind desktop icons
- Multi-monitor support (one video per screen)
- Custom MP4 import
- Battery-aware pause (pauses on battery < 20%)
- Fullscreen detection (pauses during fullscreen apps)
- Menu bar control
- <2% CPU, <80MB RAM per 4K video

## Build & Run

```bash
xcodebuild -scheme WallpaperApp -configuration Debug build
```

Requires macOS 13+ (Ventura or later).

## Installation

Download the DMG from [Releases](https://github.com/elyricmo/wallpaper-player-mac/releases) and drag WallpaperApp.app to Applications.

**Note:** Unsigned DMG requires right-click → Open on first launch (Gatekeeper).

## Development

See [CLAUDE.md](CLAUDE.md) for architecture and design decisions.

## License

MIT
