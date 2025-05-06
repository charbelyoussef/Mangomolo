//
//  SubscriptionCheckBox.swift
//  Mangomolo
//
//  Created by Charbel youssef on 02/05/2025.
//

import UIKit
import SwiftUI
import KeychainAccess

struct SubscriptionCheckBox: View {
    @State private var isChecked: Bool = false
    
    var body: some View {
        ZStack{
            
            isChecked ? Color.green : Color.red
            
            VStack {
                Button(action: {
                    withAnimation(.spring(response: 0.4, dampingFraction: 0.5)) {
                        isChecked.toggle()
                        Utils().saveCheckBoxValueToKeychain(isChecked)
                    }
                }) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 8)
                            .strokeBorder(Color.white, lineWidth: 2)
                            .background(Color.clear)
                            .frame(width: 40, height: 40)
                        
                        if isChecked {
                            Image(systemName: "checkmark")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(.white)
                                .transition(.scale.combined(with: .opacity))
                                .rotationEffect(.degrees(isChecked ? 0 : -90))
                        }
                    }
                }
                .buttonStyle(DefaultButtonStyle())
                
                Text("Subscribed: \(isChecked.description)")
                    .foregroundColor(.white)
                    .font(.system(size: 15, weight: .bold))
                
            }
            
        }
        .onAppear {
            let isSubscribed = Utils().loadCheckBoxValueFromKeychain()
            isChecked = isSubscribed
        }
        .cornerRadius(12)
        
        
    }
    
    
    
    
    
}
