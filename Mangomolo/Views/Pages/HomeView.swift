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
    
    
    
    var body: some View {
        NavigationView {
            
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
                            MediaCellView(media: media, orientation: .vertical, currentIndex: $currentIndex, geometry: nil)
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
                            MediaCellView(media: media, orientation: .horizontal, currentIndex: $currentIndex, geometry: nil)
                        }
                    }
                }
                
                //                PageControl(index: $currentIndex, maxIndex: ((mediaElements.count > 1) ? (mediaElements.count - 1) : 0))
                //                    .frame(maxHeight: 15)
                
                Spacer()
                Menu {
                    Button("Option 1", action: { print("Option 1 selected") })
                    Button("Option 2", action: { print("Option 2 selected") })
                    Button("Option 3", action: { print("Option 3 selected") })
                } label: {
                    Image(systemName: "ellipsis.circle")
                        .font(.title)
                        .foregroundColor(.blue)
                }
                
            }
            .padding(.horizontal, 16)
            .navigationBarTitle(Text("Homepage"), displayMode: .automatic)
        }
        
    }
}

#Preview {
    HomeView()
}
