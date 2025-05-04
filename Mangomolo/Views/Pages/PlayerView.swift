//
//  ContentView.swift
//  Mangomolo
//
//  Created by Charbel youssef on 02/05/2025.
//

import SwiftUI
import AVKit
import KeychainAccess
import GoogleInteractiveMediaAds


struct PlayerView: View {
    
    @ObservedObject var playerViewModel: PlayerViewModel
    @State private var isPlaying: Bool = false
    @State private var isMuted: Bool = false
    @State private var player = AVPlayer()

    let media: Media

    let adsLoader = IMAAdsLoader()
    var adsManager: IMAAdsManager?

    
    init(mediaPassed: Media) {
        self.media = mediaPassed
        self.playerViewModel = PlayerViewModel(mediaPassed: mediaPassed)
    }
    
    var body: some View {
        VStack {
//            VideoPlayerView(contentUrl: URL(string: media.url)!, adTagUrl: media.adTagUrl)
//                .frame(height: 300)
//                .cornerRadius(12)
//                .padding()
            
//            media.adTagUrl
            VideoPlayer(player: playerViewModel.player)
                .onAppear {
                    let playerItem = AVPlayerItem(url: URL(string: media.url)!)
                    playerViewModel.player.replaceCurrentItem(with: playerItem)
                    playerViewModel.player.play()
                    isPlaying = true
                }
                .onDisappear {
                    playerViewModel.player.pause()
                }
                .frame(height: 300)
                .cornerRadius(12)
                .padding()
            
            Spacer()
            
            
            HStack {
                Button(action: {
                    playerViewModel.seekBackward()
                }) {
                    Text("10 <" )
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                
                Button(action: {
                    playerViewModel.playPause()
                    isPlaying.toggle()

                }) {
                    
                    Text(isPlaying ? "Pause" : "Play")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                
                Button(action: {
                    playerViewModel.muteUnmute()
                    isMuted.toggle()
                }) {
                    
                    Text(isMuted ? "Unmute" : "Mute")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                
                Button(action: {
                    playerViewModel.seekForward()
                }) {
                    
                    Text("> 10")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            
            Spacer()
        }
        .navigationTitle("Media Player")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear(){
            let isSubscribed = Utils().loadCheckBoxValueFromKeychain()
            if isSubscribed == false {
                // play ad here
                print("whatttt ? " + String(isSubscribed))
            }
        }
    }
    
    
    
}

//#Preview {
//    PlayerView(media: Media(id: 0, image: "horizontal_image1", name: "Tears Of Steel", url: "https://demo.unified-streaming.com/k8s/features/stable/video/tears-of-steel/tears-of-steel.ism/.m3u8", adTagUrl: "https:/ /pubads.g.doubleclick.net/gampad/ads?iu=/21775744923/external/vmap_ad_samples&sz=640x480&cust_params=sample_ar%3Dpremidpostpod&ciu_szs=300x250&gdfp_req=1&ad_rule=1&output=vmap&unviewed_position_start=1&env=vp&impl=s&cmsid=496&vid=short_onecue&correlator="))
//}
