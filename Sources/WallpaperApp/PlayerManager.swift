import AVFoundation
import Combine

private let kLastVideoURLKey = "lastVideoURL"

class PlayerManager: NSObject, ObservableObject {
    @Published var isPlaying = false
    @Published var currentVideoURL: URL? {
        didSet { persistURL(currentVideoURL) }
    }

    private var players: [AVQueuePlayer] = []
    private var loopers: [AVPlayerLooper] = []

    var savedURL: URL? {
        UserDefaults.standard.url(forKey: kLastVideoURLKey)
    }

    func createPlayer(for url: URL) -> AVQueuePlayer {
        let player = AVQueuePlayer()
        let item = AVPlayerItem(url: url)
        let looper = AVPlayerLooper(player: player, templateItem: item)

        players.append(player)
        loopers.append(looper)

        currentVideoURL = url
        player.play()
        isPlaying = true
        return player
    }

    func pause() {
        players.forEach { $0.pause() }
        isPlaying = false
    }

    func resume() {
        players.forEach { $0.play() }
        isPlaying = true
    }

    func setVolume(_ volume: Float) {
        players.forEach { $0.volume = volume }
    }

    private func persistURL(_ url: URL?) {
        if let url {
            UserDefaults.standard.set(url, forKey: kLastVideoURLKey)
        }
    }
}
