//
//  PageControl.swift
//  Mangomolo
//
//  Created by Charbel youssef on 02/05/2025.
//

import Foundation
import SwiftUI

struct PageControl: View {
    @Binding var index: Int
//    @State private var currentIndex: Int = 0

    let maxIndex: Int
    var body: some View {
        
        ZStack {
            Color.yellow.ignoresSafeArea()
            HStack(spacing: 8) {
                ForEach(0...maxIndex, id: \.self) { index in
                    if index == self.index {
                        Capsule()
                            .fill(.red.opacity(0.7))
                            .frame(width: 8, height: 4)
                            .animation(Animation.spring().delay(0.5), value: index)
                    } else {
                        Circle()
                            .fill(.gray.opacity(0.6))
                            .frame(width: 4, height: 4)
                    }
                }
            }
        }
        
    }
}
