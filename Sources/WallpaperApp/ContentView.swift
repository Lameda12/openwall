import SwiftUI

struct ContentView: View {
    @ObservedObject var playerManager: PlayerManager
    @State private var selectedFile: URL?

    var body: some View {
        VStack(spacing: 16) {
            Text("WallpaperApp")
                .font(.headline)

            HStack(spacing: 8) {
                Button(playerManager.isPlaying ? "Pause" : "Play") {
                    if playerManager.isPlaying {
                        playerManager.pause()
                    } else {
                        playerManager.resume()
                    }
                }

                Button("Pick Video") {
                    pickFile()
                }
            }

            if let url = playerManager.currentVideoURL {
                Text(url.lastPathComponent)
                    .font(.caption)
                    .foregroundColor(.gray)
            }

            Divider()

            Text("macOS 13+")
                .font(.caption2)
                .foregroundColor(.gray)
        }
        .padding(12)
        .frame(width: 200)
    }

    private func pickFile() {
        let panel = NSOpenPanel()
        panel.allowedContentTypes = [.video]
        panel.allowsMultipleSelection = false
        panel.canChooseDirectories = false

        panel.begin { response in
            if response == .OK, let url = panel.url {
                playerManager.currentVideoURL = url
            }
        }
    }
}
