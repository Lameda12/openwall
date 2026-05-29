import AppKit
import SwiftUI
import Combine

@MainActor
class AppDelegate: NSObject, NSApplicationDelegate {
    var playerManager: PlayerManager?
    var powerMonitor: PowerMonitor?
    var menuBarController: MenuBarController?
    var wallpaperWindows: [WallpaperWindow] = []
    private var cancellable: AnyCancellable?

    func applicationDidFinishLaunching(_ notification: Notification) {
        setupComponents()
        setupWallpaperWindows()
        loadSavedVideo()
        observeVideoChanges()
    }

    private func setupComponents() {
        playerManager = PlayerManager()
        powerMonitor = PowerMonitor(playerManager: playerManager!)
        menuBarController = MenuBarController(playerManager: playerManager!)
    }

    private func setupWallpaperWindows() {
        for screen in NSScreen.screens {
            let window = WallpaperWindow(screen: screen, playerManager: playerManager!)
            wallpaperWindows.append(window)
            window.orderFrontRegardless()
        }
    }

    private func loadSavedVideo() {
        let url = playerManager?.savedURL ?? bundledDefaultVideo()
        guard let url else { return }
        wallpaperWindows.forEach { $0.setupPlayerLayer(with: url) }
    }

    private func bundledDefaultVideo() -> URL? {
        Bundle.main.url(forResource: "default-wallpaper", withExtension: "mp4")
    }

    private func observeVideoChanges() {
        cancellable = playerManager?.$currentVideoURL
            .compactMap { $0 }
            .sink { [weak self] url in
                self?.wallpaperWindows.forEach { $0.setupPlayerLayer(with: url) }
            }
    }

    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        false
    }
}
