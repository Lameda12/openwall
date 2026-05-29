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
            self?.updateBatteryStatus()
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

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
