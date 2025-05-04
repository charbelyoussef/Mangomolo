//
//  PlayerController.swift
//  Mangomolo
//
//  Created by Charbel youssef on 02/05/2025.
//

import Foundation
import SwiftUI
import AVKit
import GoogleInteractiveMediaAds

// TEMPPPPP
struct VideoPlayerView: UIViewControllerRepresentable {
    let contentUrl: URL
    let adTagUrl: String
    
    func makeUIViewController(context: Context) -> AVPlayerViewController {
        return context.coordinator.playerViewController
    }
    
    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(contentUrl: contentUrl, adTagUrl: adTagUrl)
    }
    
    class Coordinator: NSObject, IMAAdsLoaderDelegate, IMAAdsManagerDelegate {
        let contentUrl: URL
        let adTagUrl: String
        let playerViewController = AVPlayerViewController()
        var player: AVPlayer!
        var adsLoader: IMAAdsLoader!
        var adsManager: IMAAdsManager?
        
        var isInPostroll = false
        
        init(contentUrl: URL, adTagUrl: String) {
            self.contentUrl = contentUrl
            self.adTagUrl = adTagUrl
            super.init()
            setUpContentPlayer()
            setUpAdsLoader()
            requestAds()
        }
        
        private func setUpContentPlayer() {
            player = AVPlayer(url: contentUrl)
            playerViewController.player = player
        }
        
        private func setUpAdsLoader() {
            IMASettings().enableDebugMode = true
            adsLoader = IMAAdsLoader(settings: IMASettings())
            adsLoader.delegate = self
        }
        
        private func requestAds() {
            let adDisplayContainer = IMAAdDisplayContainer(adContainer: playerViewController.contentOverlayView!, viewController: playerViewController, companionSlots: nil) //playerViewController.contentOverlayView!
            let request = IMAAdsRequest(
                adTagUrl: adTagUrl,
                adDisplayContainer: adDisplayContainer,
                contentPlayhead: IMAAVPlayerContentPlayhead(avPlayer: player),
                userContext: nil
            )
            adsLoader.requestAds(with: request)
        }
        
        // MARK: - IMAAdsLoaderDelegate
        func adsLoader(_ loader: IMAAdsLoader, adsLoadedWith adsLoadedData: IMAAdsLoadedData) {
            adsManager = adsLoadedData.adsManager
            adsManager?.delegate = self
            let adsRenderingSettings = IMAAdsRenderingSettings()
            adsManager?.initialize(with: adsRenderingSettings)
        }
        
        func adsLoader(_ loader: IMAAdsLoader, failedWith adErrorData: IMAAdLoadingErrorData) {
            print("Ad loading error: \(adErrorData.adError.message ?? "Unknown error")")
            player.play() // Fallback to content
        }
        
        // MARK: - IMAAdsManagerDelegate
        func adsManager(_ adsManager: IMAAdsManager, didReceive event: IMAAdEvent) {
            switch event.type {
            case .AD_BREAK_STARTED:
                if let ad = event.ad, ad.adPodInfo.podIndex == -1 && ad.adPodInfo.isBumper == false {
                    isInPostroll = true
                }
            case .AD_BREAK_ENDED:
                isInPostroll = false
            case .COMPLETE:
                if isInPostroll {
                    print("Post-roll ad finished")
                    // Handle end-of-video logic
                }
            case .LOADED:
                adsManager.start()
            default:
                break
            }
        }
        
        func adsManager(_ adsManager: IMAAdsManager, didReceive error: IMAAdError) {
            print("Ad error: \(error.message ?? "Unknown")")
            player.play() // Resume content if ad fails
        }
        
        func adsManagerDidRequestContentPause(_ adsManager: IMAAdsManager) {
            player.pause()
        }
        
        func adsManagerDidRequestContentResume(_ adsManager: IMAAdsManager) {
            player.play()
        }
    }
}
