import AppKit
import SwiftUI

class MenuBarController: NSObject {
    private let playerManager: PlayerManager
    private var statusItem: NSStatusItem?
    private var popover: NSPopover?

    init(playerManager: PlayerManager) {
        self.playerManager = playerManager
        super.init()
        setupMenuBar()
    }

    private func setupMenuBar() {
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.squareLength)

        if let button = statusItem?.button {
            button.image = NSImage(systemSymbolName: "play.circle.fill", accessibilityDescription: "Wallpaper")
            button.action = #selector(togglePopover)
            button.target = self
        }
    }

    @objc private func togglePopover() {
        guard let button = statusItem?.button else { return }

        if popover?.isShown == true {
            popover?.performClose(nil)
            popover = nil
        } else {
            showPopover(for: button)
        }
    }

    private func showPopover(for button: NSButton) {
        let contentView = ContentView(playerManager: playerManager)
        let viewController = NSHostingController(rootView: contentView)

        popover = NSPopover()
        popover?.contentViewController = viewController
        popover?.behavior = .transient

        popover?.show(relativeTo: button.bounds, of: button, preferredEdge: .minY)
    }
}
