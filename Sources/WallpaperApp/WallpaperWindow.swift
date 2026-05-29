import AppKit
import AVFoundation

class WallpaperWindow: NSWindow {
    private let playerManager: PlayerManager
    private let targetScreen: NSScreen
    private var playerLayer: AVPlayerLayer?

    init(screen: NSScreen, playerManager: PlayerManager) {
        self.playerManager = playerManager
        self.targetScreen = screen

        let frame = screen.frame
        super.init(
            contentRect: frame,
            styleMask: [],
            backing: .buffered,
            defer: false
        )

        setupWindow()
        setupPlayerLayer()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) not supported")
    }

    private func setupWindow() {
        level = NSWindow.Level(rawValue: Int(CGWindowLevelForKey(.desktopWindow)) - 1)
        collectionBehavior = [.canJoinAllSpaces, .stationary]
        isOpaque = true
        hasShadow = false
        canHide = false
        isReleasedWhenClosed = false
        animationBehavior = .none

        let contentView = NSView(frame: targetScreen.frame)
        contentView.autoresizesSubviews = true
        contentView.wantsLayer = true
        self.contentView = contentView

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(screenParametersChanged),
            name: NSApplication.didChangeScreenParametersNotification,
            object: nil
        )
    }

    private func setupPlayerLayer() {
        guard let contentView = contentView else { return }

        let testURL = URL(fileURLWithPath: "/tmp/test.mp4")
        let player = playerManager.createPlayer(for: testURL)

        playerLayer = AVPlayerLayer(player: player)
        playerLayer?.frame = contentView.bounds
        playerLayer?.videoGravity = .resizeAspectFill

        contentView.layer?.addSublayer(playerLayer!)
    }

    @objc private func screenParametersChanged() {
        setFrame(targetScreen.frame, display: true, animate: false)
        playerLayer?.frame = contentView?.bounds ?? .zero
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
