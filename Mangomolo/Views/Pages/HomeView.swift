//
//  ContentView.swift
//  Mangomolo
//
//  Created by Charbel youssef on 02/05/2025.
//

import SwiftUI
import KeychainAccess

struct HomeView: View {
    @State private var currentIndex: Int = 0
    
    let mediaElements = [
        Media(id: 0, image: "vertical_image1", name: "Tears Of Steel", url: "https://demo.unified-streaming.com/k8s/features/stable/video/tears-of-steel/tears-of-steel.ism/.m3u8"),
        Media(id: 1, image: "image1", name: "song1", url: "https://demo.unified-streaming.com/k8s/features/stable/video/tears-of-steel/tears-of-steel.ism/.m3u8"),
        Media(id: 2, image: "image2", name: "song2", url: "https://demo.unified-streaming.com/k8s/features/stable/video/tears-of-steel/tears-of-steel.ism/.m3u8"),
        Media(id: 3, image: "image3", name: "song3", url: "https://demo.unified-streaming.com/k8s/features/stable/video/tears-of-steel/tears-of-steel.ism/.m3u8"),
        Media(id: 4, image: "image4", name: "song4", url: "https://demo.unified-streaming.com/k8s/features/stable/video/tears-of-steel/tears-of-steel.ism/.m3u8"),
        Media(id: 5, image: "image5", name: "song5", url: "https://demo.unified-streaming.com/k8s/features/stable/video/tears-of-steel/tears-of-steel.ism/.m3u8"),
        Media(id: 6, image: "image6", name: "song6", url: "https://demo.unified-streaming.com/k8s/features/stable/video/tears-of-steel/tears-of-steel.ism/.m3u8"),
        Media(id: 7, image: "image7", name: "song7", url: "https://demo.unified-streaming.com/k8s/features/stable/video/tears-of-steel/tears-of-steel.ism/.m3u8"),
        Media(id: 8, image: "image8", name: "song8", url: "https://demo.unified-streaming.com/k8s/features/stable/video/tears-of-steel/tears-of-steel.ism/.m3u8"),
        Media(id: 9, image: "image9", name: "song9", url: "https://demo.unified-streaming.com/k8s/features/stable/video/tears-of-steel/tears-of-steel.ism/.m3u8"),
    ]
    
    var body: some View {
        NavigationStack {
            
            VStack(alignment: .center) {
                SubscriptionCheckBox()
                    .frame(maxHeight: 80)

                VerticalCarousel(mediaElements: mediaElements, currentIndex: $currentIndex)
                    .frame(maxHeight: 200)

                PageControl(index: $currentIndex, maxIndex: ((mediaElements.count > 1) ? (mediaElements.count - 1) : 0))
                    .frame(maxHeight: 15)

                Spacer()
            }
            .padding(.horizontal, 16)
            .navigationBarTitle(Text("Homepage"), displayMode: .automatic)
        }
    }
}

#Preview {
    HomeView()
}
