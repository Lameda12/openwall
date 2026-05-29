import AVFoundation
import Combine

class PlayerManager: NSObject, ObservableObject {
    @Published var isPlaying = false
    @Published var currentVideoURL: URL?

    private var players: [AVQueuePlayer] = []
    private var loopers: [AVPlayerLooper] = []

    func createPlayer(for url: URL) -> AVQueuePlayer {
        let player = AVQueuePlayer()
        let item = AVPlayerItem(url: url)
        let looper = AVPlayerLooper(player: player, templateItem: item)

        players.append(player)
        loopers.append(looper)
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
}
