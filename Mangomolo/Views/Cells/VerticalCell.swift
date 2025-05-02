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
    
    @Binding var currentIndex: Int
    let geometry: GeometryProxy
    
    var body: some View {
        let mediaWidth = geometry.size.width * 0.25
        let mediaHeight : CGFloat = geometry.size.height
        let offset = mediaWidth //(geometry.size.width - mediaWidth) / 2
        
        return ZStack {
            
            Image(media.image)
                .resizable()
                .scaledToFill()
                .clipShape(.rect(cornerRadius: 12))

            
            NavigationLink(destination: PlayerView(media: media)) {
                VStack {
                    Spacer()
                    HStack(alignment: .center, spacing: 0) {
                        Text(media.name)
                            .foregroundColor(.white)
                        
                    }.padding(.all, 16)
                    
                }
            }
        }
        .frame(width: mediaWidth, height: mediaHeight)
        .offset(x: CGFloat(media.id - currentIndex) * offset)
    }
}

