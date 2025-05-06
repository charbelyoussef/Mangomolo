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
                PlayerViewWrapper(media: media)
            }
            .navigationTitle("Media Player")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear(){}
        }
    }
}

// Wrapper to to create a connection between SwiftUI and UIKit ("PlayerView" & "PlayerContainerViewController")
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
