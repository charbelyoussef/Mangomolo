//
//  PlayerViewModel.swift
//  Mangomolo
//
//  Created by Charbel youssef on 04/05/2025.
//

import Foundation
import SwiftUI
import AVFoundation
import AVKit
import GoogleInteractiveMediaAds
import UIKit



class PlayerViewModel: UIViewController, IMAAdsLoaderDelegate, IMAAdsManagerDelegate, ObservableObject {
    
    // Player variables
    var player = AVPlayer()
    var playerViewController: AVPlayerViewController!

    // IMA Ads variables
    var adsLoader: IMAAdsLoader!
    var adsManager: IMAAdsManager!
    var contentPlayhead: IMAAVPlayerContentPlayhead?
    
    let seekDuration: Float64 = 5
    private var media: Media?
    
    
    init(mediaPassed: Media) {
        super.init(nibName: nil, bundle: nil)
        self.media = mediaPassed
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @available(*, unavailable, message: "Nibs are unsupported")
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Controller Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black
        setUpContentPlayer()
        setUpAdsLoader()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        requestAds()
    }
    
    
    //MARK: - IMAAdsManager Delegate Methods
    func adsManager(_ adsManager: IMAAdsManager, didReceive event: IMAAdEvent) {
        // Play each ad once it has been loaded
        if event.type == IMAAdEventType.LOADED {
            adsManager.start()
        }
    }
    
    func adsManagerDidRequestContentPause(_ adsManager: IMAAdsManager) {
        // Pause the content for the SDK to play ads.
        playerViewController.player?.pause()
        hideContentPlayer()
        
    }
    
    func adsManagerDidRequestContentResume(_ adsManager: IMAAdsManager) {
        // Resume the content since the SDK is done playing ads (at least for now).
        showContentPlayer()
        playerViewController.player?.play()
        
    }
    func adsManager(_ adsManager: IMAAdsManager, didReceive error: IMAAdError) {
        // Fall back to playing content
        print("AdsManager error: " + (error.message ?? "Placeholder Message in case nil"))
        showContentPlayer()
        playerViewController.player?.play()
    }
    
    
    // MARK: - IMAAdsLoader Delegate Methods
    func adsLoader(_ loader: IMAAdsLoader, adsLoadedWith adsLoadedData: IMAAdsLoadedData) {
        adsManager = adsLoadedData.adsManager
        adsManager.initialize(with: nil)
    }
    
    func adsLoader(_ loader: IMAAdsLoader, failedWith adErrorData: IMAAdLoadingErrorData) {
        print("Error loading ads: " + (adErrorData.adError.message ?? "Placeholder in case nil"))
        showContentPlayer()
        playerViewController.player?.play()
    }
    
    // MARK: - AVPlayer Setup & Custom Methods
    func setUpContentPlayer() {
        // Load AVPlayer with path to your content.
        let contentURL = URL(string: media!.url)
        let player = AVPlayer(url: contentURL!)
        playerViewController = AVPlayerViewController()
        playerViewController.player = player
        
        contentPlayhead = IMAAVPlayerContentPlayhead(avPlayer: player)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(contentDidFinishPlaying(_:)),
            name: NSNotification.Name.AVPlayerItemDidPlayToEndTime,
            object: player.currentItem)
        
        
        showContentPlayer()
    }
    
    func setUpAdsLoader() {
        adsLoader = IMAAdsLoader(settings: nil)
    }
    
    func requestAds() {
        // Create ad display container for ad rendering.
        let adDisplayContainer = IMAAdDisplayContainer(adContainer: self.view, viewController: self)
        // Create an ad request with our ad tag, display container, and optional user context.
        let request = IMAAdsRequest(
            adTagUrl: media!.adTagUrl ,
            adDisplayContainer: adDisplayContainer,
            contentPlayhead: contentPlayhead,
            userContext: nil)
        
        adsLoader.requestAds(with: request)
    }
    
    @objc func contentDidFinishPlaying(_ notification: Notification) {
        adsLoader.contentComplete()
    }
    func showContentPlayer() {
        self.addChild(playerViewController)
        playerViewController.view.frame = self.view.bounds
        self.view.insertSubview(playerViewController.view, at: 0)
        playerViewController.didMove(toParent:self)
    }
    
    func hideContentPlayer() {
        // The whole controller needs to be detached so that it doesn't capture
        // events from the remote.
        playerViewController.willMove(toParent:nil)
        playerViewController.view.removeFromSuperview()
        playerViewController.removeFromParent()
    }
    
    // MARK: - AVPlayer Controls Methods
    func playPause(/*finished: () -> Void*/){
        if player.timeControlStatus == .playing {
            player.pause()
        } else {
            player.play()
        }
//        finished()
    }
    
    func muteUnmute(){
        player.isMuted.toggle()
    }
    
    func seekForward(){
        guard let duration  = player.currentItem?.duration else {
            return
        }
        let playerCurrentTime = CMTimeGetSeconds(player.currentTime())
        let newTime = playerCurrentTime + seekDuration
        
        if newTime < (CMTimeGetSeconds(duration) - 5) {
            let time2: CMTime = CMTimeMake(value: Int64(newTime * 1000 as Float64), timescale: 1000)
            player.seek(to: time2, toleranceBefore: CMTime.zero, toleranceAfter: CMTime.zero)
        }
    }
    
    func seekBackward(){
        let playerCurrentTime = CMTimeGetSeconds(player.currentTime())
        var newTime = playerCurrentTime - seekDuration
        
        if newTime < 0 {
            newTime = 0
        }
        let time2: CMTime = CMTimeMake(value: Int64(newTime * 1000 as Float64), timescale: 1000)
        player.seek(to: time2, toleranceBefore: CMTime.zero, toleranceAfter: CMTime.zero)
    }
}

