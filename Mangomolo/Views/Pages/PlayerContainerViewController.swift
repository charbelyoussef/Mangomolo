//
//  ContentView.swift
//  Mangomolo
//
//  Created by Charbel youssef on 02/05/2025.
//

import AVFoundation
import GoogleInteractiveMediaAds

class PlayerContainerViewController: UIViewController, IMAAdsLoaderDelegate, IMAAdsManagerDelegate {
    var media:Media?
    var seekDuration: Float64 = 10 // 720
    
    private let adsLoader = IMAAdsLoader()
    private var adsManager: IMAAdsManager?
    private var contentPlayer = AVPlayer()
    private var didFinishPlayingContentAlready = false
    private var timeObserver: Any?

    let playPauseButton = UIButton(type: .system)
    let muteUnmuteButton = UIButton(type: .system)
    let seekForwardButton = UIButton(type: .system)
    let seekBackwardButton = UIButton(type: .system)
    var buttonStack = UIStackView()
    
    private lazy var videoView: UIView = {
        let videoView = UIView()
        videoView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(videoView)
        
        NSLayoutConstraint.activate([
            videoView.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            videoView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            videoView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            videoView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
        ])
        return videoView
    }()
    
    private lazy var contentPlayhead: IMAAVPlayerContentPlayhead = {
        IMAAVPlayerContentPlayhead(avPlayer: contentPlayer)
    }()
    
    private lazy var playerLayer: AVPlayerLayer = {
        AVPlayerLayer(player: contentPlayer)
    }()
    
    init(mediaPassed: Media) {
        super.init(nibName: nil, bundle: nil)
        media = mediaPassed
        contentPlayer = AVPlayer(url: URL(string: mediaPassed.url)!)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View controller lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        videoView.layer.addSublayer(playerLayer)
        adsLoader.delegate = self
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(contentDidFinishPlaying(_:)),
            name: .AVPlayerItemDidPlayToEndTime,
            object: contentPlayer.currentItem)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        generateButtonsStack()
        playerLayer.frame = videoView.layer.bounds
        
        if(media?.adType == .preRoll){
            requestAds()
        }
        
        if(media?.adType == .midRoll){
            observeMidRollTrigger()
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        contentPlayer.pause()
        adsManager?.destroy()
        adsManager = nil
    }
    
    override func viewWillTransition(
        to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator
    ) {
        coordinator.animate { _ in
            // do nothing
        } completion: { _ in
            self.playerLayer.frame = self.videoView.layer.bounds
        }
    }
    
    
    // MARK: - Mid-Roll functions
    private func observeMidRollTrigger() {
        timeObserver = contentPlayer.addPeriodicTimeObserver(forInterval: CMTime(seconds: 1, preferredTimescale: 1),
                                                      queue: .main) { [weak self] time in
            if time.seconds >= 10 {
                self?.requestAds()
            }
        }
    }
    
    // MARK: UI Design helper methods
    func generateButtonsStack(){
        buttonStack = UIStackView(arrangedSubviews: [generateSeekBackwardButton(), generatePlayPauseButton(), generateMuteButton(), generateSeekForwardButton()])
        buttonStack.axis = .horizontal
        buttonStack.alignment = .center
        buttonStack.distribution = .equalSpacing
        buttonStack.spacing = 18
        
        // Add to view
        buttonStack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(buttonStack)
        
        // Center in the view
        NSLayoutConstraint.activate([
            buttonStack.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            buttonStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),

        ])
    }
    
    func generatePlayPauseButton() -> UIButton{
        
        playPauseButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
        playPauseButton.tintColor = .systemBlue
        playPauseButton.translatesAutoresizingMaskIntoConstraints = false
        playPauseButton.addTarget(self, action: #selector(playButtonTapped), for: .touchUpInside)
        
        view.addSubview(playPauseButton)
        return playPauseButton
    }
    
    func generateMuteButton() -> UIButton{
        
        muteUnmuteButton.setImage(UIImage(systemName: "speaker.wave.2"), for: .normal)
        muteUnmuteButton.tintColor = .systemBlue
        muteUnmuteButton.translatesAutoresizingMaskIntoConstraints = false
        muteUnmuteButton.addTarget(self, action: #selector(muteButtonTapped), for: .touchUpInside)
        
        return muteUnmuteButton
    }
    
    func generateSeekForwardButton() -> UIButton{
        
        seekForwardButton.setImage(UIImage(systemName: "goforward.10"), for: .normal)
        seekForwardButton.tintColor = .systemBlue
        seekForwardButton.translatesAutoresizingMaskIntoConstraints = false
        seekForwardButton.addTarget(self, action: #selector(seekForwardButtonTapped), for: .touchUpInside)
        
        return seekForwardButton
    }
    
    func generateSeekBackwardButton() -> UIButton{
        seekBackwardButton.setImage(UIImage(systemName: "gobackward.10"), for: .normal)
        seekBackwardButton.tintColor = .systemBlue
        seekBackwardButton.translatesAutoresizingMaskIntoConstraints = false
        seekBackwardButton.addTarget(self, action: #selector(seekBackwardButtonTapped), for: .touchUpInside)
        
        return seekBackwardButton
    }
        
    // MARK: - AVPlayer Controls Methods
    @objc func playButtonTapped(button: UIButton) {
        playPause(sender: button)
    }
    
    func playPause(sender: UIButton){
        if contentPlayer.timeControlStatus == .playing {
            contentPlayer.pause()
            sender.setImage(UIImage(systemName: "play.fill"), for: .normal)
        } else {
            sender.setImage(UIImage(systemName: "pause.fill"), for: .normal)
            contentPlayer.play()
        }
    }
    
    func play(sender: UIButton){
        sender.setImage(UIImage(systemName: "pause.fill"), for: .normal)
        contentPlayer.play()
    }
    
    func pause(sender: UIButton){
        if contentPlayer.timeControlStatus == .playing {
            contentPlayer.pause()
            sender.setImage(UIImage(systemName: "play.fill"), for: .normal)
        }
    }
    
    @objc func muteButtonTapped(button: UIButton) {
        muteUnmute(sender: button)
    }
    
    func muteUnmute(sender: UIButton){
        if contentPlayer.isMuted {
            sender.setImage(UIImage(systemName: "speaker.wave.2"), for: .normal)
        }
        else{
            sender.setImage(UIImage(systemName: "speaker.slash"), for: .normal)
        }
        contentPlayer.isMuted.toggle()
    }
    
    
    @objc func seekForwardButtonTapped(button: UIButton) {
        seekForward(sender: button)
    }
    
    func seekForward(sender: UIButton){
        guard let duration  = contentPlayer.currentItem?.duration else {
            return
        }
        let playerCurrentTime = CMTimeGetSeconds((contentPlayer.currentTime()))
        let newTime = playerCurrentTime + seekDuration
        
        if newTime < (CMTimeGetSeconds(duration) - 5) {
            let time2: CMTime = CMTimeMake(value: Int64(newTime * 1000 as Float64), timescale: 1000)
            contentPlayer.seek(to: time2, toleranceBefore: CMTime.zero, toleranceAfter: CMTime.zero)
        }
    }
    
    @objc func seekBackwardButtonTapped(button: UIButton) {
        seekBackward(sender: button)
    }
    
    func seekBackward(sender: UIButton){
        let playerCurrentTime = CMTimeGetSeconds((contentPlayer.currentTime()))
        var newTime = playerCurrentTime - seekDuration
        
        if newTime < 0 {
            newTime = 0
        }
        let time2: CMTime = CMTimeMake(value: Int64(newTime * 1000 as Float64), timescale: 1000)
        contentPlayer.seek(to: time2, toleranceBefore: CMTime.zero, toleranceAfter: CMTime.zero)
    }
    
    
    // MARK: - IMA integration methods
    private func requestAds() {
        let isSubscribed = Utils().loadCheckBoxValueFromKeychain()
        
        if(isSubscribed == true) {
            return
        }

        if(media?.adType == .midRoll){
            guard timeObserver != nil else { return }
            
            // Remove observer to prevent repeated ads
            contentPlayer.removeTimeObserver(timeObserver!)
            timeObserver = nil
            
            contentPlayer.pause()
        }
        // Create ad display container for ad rendering.
        let adDisplayContainer = IMAAdDisplayContainer(
            adContainer: videoView, viewController: self, companionSlots: nil)
        // Create an ad request with our ad tag, display container, and optional user context.
        let request = IMAAdsRequest(
            adTagUrl: media!.adTagUrl,
            adDisplayContainer: adDisplayContainer,
            contentPlayhead: contentPlayhead,
            userContext: nil)
        
        adsLoader.requestAds(with: request)
    }
    
    // MARK: - Content player methods
    @objc func contentDidFinishPlaying(_ notification: Notification) {
        // Make sure we don't call contentComplete as a result of an ad completing.
        if notification.object as? AVPlayerItem == contentPlayer.currentItem {
            adsLoader.contentComplete()
            contentPlayer.seek(to: .zero)
            pause(sender: playPauseButton)
            if(media?.adType == .postRoll){
                requestAds()
            }
            if(media?.adType == .midRoll){
                observeMidRollTrigger()
            }
        }
    }
    
    // MARK: - IMAAdsLoaderDelegate
    func adsLoader(_ loader: IMAAdsLoader, adsLoadedWith adsLoadedData: IMAAdsLoadedData) {
        // Grab the instance of the IMAAdsManager and set ourselves as the delegate.
        adsManager = adsLoadedData.adsManager
        adsManager?.delegate = self
        
        // Create ads rendering settings and tell the SDK to use the in-app browser.
        let adsRenderingSettings = IMAAdsRenderingSettings()
        adsRenderingSettings.linkOpenerPresentingController = self
        
        // Initialize the ads manager.
        adsManager?.initialize(with: adsRenderingSettings)
    }
    
    func adsLoader(_ loader: IMAAdsLoader, failedWith adErrorData: IMAAdLoadingErrorData) {
        if let message = adErrorData.adError.message {
            print("Error loading ads: \(message)")
        }
        //        contentPlayer.play()
        play(sender: playPauseButton)
    }
    
    // MARK: - IMAAdsManagerDelegate
    func adsManager(_ adsManager: IMAAdsManager, didReceive event: IMAAdEvent) {
        // When the SDK notifies us the ads have been loaded, play them.
        if event.type == IMAAdEventType.LOADED {
            adsManager.start()
        }
        if event.type == IMAAdEventType.COMPLETE {
            print("IMAAdEventType.COMPLETE : COMPLETEEEE")
        }
    }
    
    func adsManager(_ adsManager: IMAAdsManager, didReceive error: IMAAdError) {
        // Something went wrong with the ads manager after ads were loaded.
        // Log the error and play the content.
        if let message = error.message {
            print("AdsManager error: \(message)")
        }
        //        contentPlayer.play()
        play(sender: playPauseButton)
    }
    
    func adsManagerDidRequestContentPause(_ adsManager: IMAAdsManager) {
        // The SDK is going to play ads, so pause the content.
        //        contentPlayer.pause()
        buttonStack.isHidden = true
        pause(sender: playPauseButton)
        
    }
    
    func adsManagerDidRequestContentResume(_ adsManager: IMAAdsManager) {
        // The SDK is done playing ads (at least for now), so resume the content.
        buttonStack.isHidden = false
        if(media?.adType == .preRoll || media?.adType == .midRoll){
            play(sender: playPauseButton)
        }
    }
    
    // MARK: - deinit
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Public methods
}



