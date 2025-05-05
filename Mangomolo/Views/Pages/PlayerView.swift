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
    let enablePurpleMode: Bool
    let media: Media
    
    var body: some View {
        ZStack {
            enablePurpleMode ? Color.purple.ignoresSafeArea() : Color.white.ignoresSafeArea()
            
            VStack {
                ZStack {
                    PlayerViewWrapper(
                        media: media)
                }
                .aspectRatio(16 / 9, contentMode: .fit)
                .padding()

                Spacer()
            }
            .navigationTitle("Media Player")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear(){}
        }
    }
}

private struct PlayerViewWrapper: UIViewControllerRepresentable {
    typealias UIViewControllerType = PlayerContainerViewController
    
    var media: Media
    
    func makeUIViewController(context: Context) -> PlayerContainerViewController {
        let vc = PlayerContainerViewController(mediaPassed: media)
        return vc
    }
    
    func updateUIViewController(_ uiViewController: PlayerContainerViewController, context: Context) {
    }
}
