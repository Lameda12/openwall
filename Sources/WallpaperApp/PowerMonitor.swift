import AppKit

@MainActor
class PowerMonitor {
    private let playerManager: PlayerManager
    private var batteryLevel: Int = 100
    private var isOnBattery = false

    init(playerManager: PlayerManager) {
        self.playerManager = playerManager
        setupBatteryMonitoring()
        setupScreenSleepMonitoring()
        setupFullscreenMonitoring()
    }

    private func setupBatteryMonitoring() {
        let process = Process()
        process.executableURL = URL(fileURLWithPath: "/usr/bin/pmset")
        process.arguments = ["-g", "batt"]

        let pipe = Pipe()
        process.standardOutput = pipe
        try? process.run()
        process.waitUntilExit()

        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        if let output = String(data: data, encoding: .utf8) {
            parseBatteryInfo(output)
        }

        Timer.scheduledTimer(withTimeInterval: 30, repeats: true) { [weak self] _ in
            Task { @MainActor in self?.updateBatteryStatus() }
        }
    }

    private func updateBatteryStatus() {
        if isOnBattery && batteryLevel < 20 {
            playerManager.pause()
        } else {
            playerManager.resume()
        }
    }

    private func parseBatteryInfo(_ output: String) {
        if output.contains("Battery Power") {
            isOnBattery = true
        } else {
            isOnBattery = false
        }

        let lines = output.split(separator: "\n")
        for line in lines {
            if line.contains("%") {
                if let range = line.range(of: "(\\d+)%", options: .regularExpression) {
                    let percent = String(line[range]).dropLast()
                    batteryLevel = Int(percent) ?? 100
                }
            }
        }
    }

    private func setupScreenSleepMonitoring() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(screenWillSleep),
            name: NSWorkspace.screensDidSleepNotification,
            object: nil
        )

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(screenDidWake),
            name: NSWorkspace.screensDidWakeNotification,
            object: nil
        )
    }

    @objc private func screenWillSleep() {
        playerManager.pause()
    }

    @objc private func screenDidWake() {
        playerManager.resume()
    }

    private func setupFullscreenMonitoring() {
        NSWorkspace.shared.notificationCenter.addObserver(
            self,
            selector: #selector(activeSpaceChanged),
            name: NSWorkspace.activeSpaceDidChangeNotification,
            object: nil
        )
        Timer.scheduledTimer(withTimeInterval: 2, repeats: true) { [weak self] _ in
            Task { @MainActor in self?.checkFullscreen() }
        }
    }

    private func checkFullscreen() {
        let isFullscreen = NSScreen.screens.contains { screen in
            guard screen.deviceDescription[NSDeviceDescriptionKey("NSScreenNumber")] is CGDirectDisplayID else { return false }
            let windowList = CGWindowListCopyWindowInfo([.optionOnScreenOnly, .excludeDesktopElements], kCGNullWindowID) as? [[String: Any]] ?? []
            return windowList.contains { info in
                guard let bounds = info[kCGWindowBounds as String] as? [String: CGFloat],
                      let layer = info[kCGWindowLayer as String] as? Int,
                      layer == 0 else { return false }
                let winRect = CGRect(x: bounds["X"] ?? 0, y: bounds["Y"] ?? 0,
                                     width: bounds["Width"] ?? 0, height: bounds["Height"] ?? 0)
                return winRect == screen.frame
            }
        }

        if isFullscreen {
            playerManager.pause()
        } else if !isOnBattery || batteryLevel >= 20 {
            playerManager.resume()
        }
    }

    @objc private func activeSpaceChanged() {
        checkFullscreen()
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
        NSWorkspace.shared.notificationCenter.removeObserver(self)
    }
}
