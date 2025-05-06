//
//  ContentView.swift
//  Mangomolo
//
//  Created by Charbel youssef on 02/05/2025.
//

import SwiftUI

struct HomeView: View {
    @State private var currentIndex: Int = 0
    @State private var enablePurpleMode: Bool = false
    @State private var isJiggling = false
    @State private var jiggleAngle: Double = 0
    @State private var jiggleTimer: Timer?
    @State private var stopTimer: Timer?
    let jiggleDuration: TimeInterval = 4.0
    
    var body: some View {
        NavigationView {
            ZStack {
                enablePurpleMode ? Color.purple.ignoresSafeArea() : Color.white.ignoresSafeArea()
                
                VStack(alignment: .center) {
                    //Subscription struct that handles fetching data from keychain in order to check subscription status
                    SubscriptionCheckBox()
                        .frame(maxHeight: 80)
                    
                    // Title for Vertical Carousel
                    HStack {
                        Text("Vertical Sample")
                            .foregroundColor(.black)
                            .font(.system(size: 18, weight: .bold))
                            .truncationMode(.tail)
                            .lineLimit(2)
                        Spacer()
                    }
                    
                    // ScrollView that contains all the vertical elements from the Constants class
                    ScrollView (.horizontal){
                        HStack {
                            ForEach(Constants.mediaVerticalElements) { media in
                                MediaCellView(media: media,
                                              orientation: .vertical,
                                              enablePurpleMode: enablePurpleMode,
                                              currentIndex: $currentIndex,
                                              geometry: nil)
                            }
                        }
                    }
                    
                    // Title for Horizontal Carousel
                    HStack {
                        Text("Horizontal Sample")
                            .foregroundColor(.black)
                            .font(.system(size: 18, weight: .bold))
                            .truncationMode(.tail)
                            .lineLimit(2)
                        Spacer()
                    }
                    
                    // ScrollView that contains all the horizontal elements from the Constants class
                    ScrollView (.horizontal){
                        HStack {
                            ForEach(Constants.mediahorizontalElements) { media in
                                MediaCellView(media: media,
                                              orientation: .horizontal,
                                              enablePurpleMode: enablePurpleMode,
                                              currentIndex: $currentIndex,
                                              geometry: nil)
                            }
                        }
                    }
                    
                    Spacer()
                    HStack{
                        Spacer()
                        
                        Menu {
                            Button(enablePurpleMode ? "Light Mode" : "Purple Mode", action: { enablePurpleMode.toggle() })
                            Button("Make It Dance!!", action: { startJiggleWithAutoStop() })
                        } label: {
                            Image(systemName: "line.3.horizontal")
                                .font(.title)
                                .foregroundColor(.white)
                                .padding(5)
                        }
                        .padding()
                        .background(Circle().fill(LinearGradient(
                            gradient: Gradient(colors: [Color.black, Color.gray]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                        .opacity(0.6)
                        ))
        
                    }
                    Spacer()
                    
                }
                .padding(.horizontal, 16)
                .navigationBarTitle(Text("Homepage"), displayMode: .automatic)
            }
            .rotationEffect(.degrees(jiggleAngle))
            
        }
        .onDisappear {
            stopJiggle()
        }
    }
    
    // Function called to animate the content horizontally
    func startJiggleWithAutoStop() {
        guard !isJiggling else { return }
        
        isJiggling = true
        
        // Start jiggle animation
        jiggleTimer = Timer.scheduledTimer(withTimeInterval: 0.12, repeats: true) { _ in
            withAnimation(.easeInOut(duration: 0.12)) {
                jiggleAngle = jiggleAngle == 2 ? -2 : 2
            }
        }
        
        // Schedule auto-stop
        stopTimer = Timer.scheduledTimer(withTimeInterval: jiggleDuration, repeats: false) { _ in
            stopJiggle()
        }
    }
    
    // Called to stop jiggle animation
    func stopJiggle() {
        isJiggling = false
        jiggleTimer?.invalidate()
        stopTimer?.invalidate()
        jiggleTimer = nil
        stopTimer = nil
        
        withAnimation {
            jiggleAngle = 0
        }
    }
}

#Preview {
    HomeView()
}
