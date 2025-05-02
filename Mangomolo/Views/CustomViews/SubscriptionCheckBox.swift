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
    
    private let keychainKey = "com.charbelyoussef.mangomolo"
    private let keychain = Keychain(service: "com.charbelyoussef")

    var body: some View {
        ZStack{
            Color.green
            VStack {
                Button(action: {
                    withAnimation(.spring(response: 0.4, dampingFraction: 0.5)) {
                        isChecked.toggle()
                        saveCheckBoxValueToKeychain(isChecked)
                    }
                }) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 8)
                            .strokeBorder(isChecked ? Color.green : Color.gray, lineWidth: 2)
                            .background(isChecked ? Color.green.opacity(0.2) : Color.clear)
                            .frame(width: 40, height: 40)
                        
                        if isChecked {
                            Image(systemName: "checkmark")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(.green)
                                .transition(.scale.combined(with: .opacity))
                                .rotationEffect(.degrees(isChecked ? 0 : -90))
                        }
                    }
                }
                .buttonStyle(PlainButtonStyle())
                
                Text("Checked: \(isChecked.description)")
            }
        }
        .onAppear {
            loadCheckBoxValueFromKeychain()
        }

    }
    
    
    
    // MARK: - Keychain Methods
    /// Save the checkbox value to keychain for onAppear retrieval
    private func saveCheckBoxValueToKeychain(_ value: Bool) {
        do {
            try keychain.set(value ? "true" : "false", key: keychainKey)
        } catch {
            print("Error saving to Keychain: \(error)")
        }
    }
    
    /// Retrieve the checkbox value from keychain onAppear of Homepage view
    private func loadCheckBoxValueFromKeychain() {
        do {
            if let value = try keychain.get(keychainKey) {
                isChecked = (value == "true")
            }
        } catch {
            print("Error loading from Keychain: \(error)")
        }
    }
    
}
