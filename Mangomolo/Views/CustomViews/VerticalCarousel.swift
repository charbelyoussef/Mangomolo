//
//  VerticalCarousel.swift
//  Mangomolo
//
//  Created by Charbel youssef on 02/05/2025.
//

import SwiftUI

struct VerticalCarousel: View {
    var mediaElements: [Media]
    @Binding var currentIndex: Int

    var body: some View {
        ZStack {
            Color.purple.ignoresSafeArea()
            
            GeometryReader { geometry in
                // Carousel content here
                ZStack {
                    ForEach(mediaElements) { media in
                        MediaCellView(media: media,
                                      orientation: .vertical,
                                      currentIndex: $currentIndex,
                                      geometry: geometry)
                        
                        .offset(x: CGFloat(media.id - currentIndex) * (geometry.size.width * 0.7))
                    }
                }
                .gesture(
                    DragGesture()
                        .onEnded { value in
                            let cardWidth = geometry.size.width * 0.2
                            let offset = value.translation.width / cardWidth
                            
                            withAnimation(Animation.spring()) {
                                if value.translation.width < -offset
                                {
                                    currentIndex = min(currentIndex + 1, mediaElements.count - 1)
                                } else if value.translation.width > offset {
                                    currentIndex = max(currentIndex - 1, 0)
                                }
                            }
                        }
                )
            }
        }
    }
}


