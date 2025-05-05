//
//  VerticalCell.swift
//  Mangomolo
//
//  Created by Charbel youssef on 02/05/2025.
//

import Foundation
import SwiftUI

struct MediaCellView: View {
    let media: Media
    let orientation: MediaCellOrientation
    let enablePurpleMode: Bool
    
    @Binding var currentIndex: Int
    let geometry: GeometryProxy?
    
    var body: some View {
        let mediaWidth = orientation == .horizontal ? 200.0 : 120.0
        let mediaHeight = orientation == .horizontal ? 120.0 : 200.0

//        let offset = mediaWidth/2 //(geometry.size.width - mediaWidth) / 2
        
        NavigationLink(destination: PlayerView( enablePurpleMode: enablePurpleMode, media: media)) {
            ZStack {
                Image(media.image)
                    .resizable()
//                    .frame(width: mediaWidth, height: mediaHeight)
                
                VStack(alignment: .center, content: {
                    Spacer()
                    HStack() {
                        ZStack {
                            LinearGradient(
                                gradient: Gradient(colors: [Color.black, Color.gray]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                            .frame(maxHeight: 40)
                            .opacity(0.7)

                            Text(media.name)
                                .foregroundColor(.white)
                                .font(.system(size: 12, weight: .bold))
                                .truncationMode(.tail)
                                .lineLimit(2)
                        }
                    }
                    .frame(maxHeight: 40)
                })
            }
            .frame(width: mediaWidth, height: mediaHeight)         
        }
        .clipShape(.rect(cornerRadius: 12))
    }
}

