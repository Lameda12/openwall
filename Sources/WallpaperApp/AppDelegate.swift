import AppKit
import SwiftUI

@MainActor
class AppDelegate: NSObject, NSApplicationDelegate {
    var playerManager: PlayerManager?
    var powerMonitor: PowerMonitor?
    var menuBarController: MenuBarController?
    var wallpaperWindows: [WallpaperWindow] = []

    func applicationDidFinishLaunching(_ notification: Notification) {
        setupComponents()
        setupWallpaperWindows()
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

    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        false
    }
}
