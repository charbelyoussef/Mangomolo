//
//  ContentView.swift
//  Mangomolo
//
//  Created by Charbel youssef on 02/05/2025.
//

import SwiftUI
import AVKit

struct PlayerView: View {
    
    let media: Media
    // Replace with your HLS stream URL

    @State private var player = AVPlayer()

    var body: some View {
        VStack {
            VideoPlayer(player: player)
                .onAppear {
                    let playerItem = AVPlayerItem(url: URL(string: media.url)!)
                    player.replaceCurrentItem(with: playerItem)
                    player.play()
                }
                .onDisappear {
                    player.pause()
                }
                .frame(height: 300)
                .cornerRadius(12)
                .padding()

            Spacer()

            Button(action: {
                if player.timeControlStatus == .playing {
                    player.pause()
                } else {
                    player.play()
                }
            }) {
                Text(player.timeControlStatus == .playing ? "Pause" : "Play")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }

            Spacer()
        }
        .navigationTitle("HLS Player")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    PlayerView(media: Media(id: 0, image: "horizontal_image1", name: "Tears Of Steel", url: "https://demo.unified-streaming.com/k8s/features/stable/video/tears-of-steel/tears-of-steel.ism/.m3u8"))
}
