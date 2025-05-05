//
//  Utils.swift
//  Mangomolo
//
//  Created by Charbel youssef on 03/05/2025.
//

import Foundation

struct Constants {
    static let mediaVerticalElements = [
        Media(id: 0, image: "vertical_image1",
              name: "Pre-Roll", url: "https://storage.googleapis.com/interactive-media-ads/media/stock.mp4",
              adTagUrl: "https://pubads.g.doubleclick.net/gampad/ads?iu=/21775744923/external/single_ad_samples&sz=640x480&cust_params=sample_ct%3Dlinear&ciu_szs=300x250%2C728x90&gdfp_req=1&output=vast&unviewed_position_start=1&env=vp&impl=s&correlator=",
              adType: .preRoll),
        Media(id: 1, image: "vertical_image1",
              name: "Post-Roll", 
              url: "https://storage.googleapis.com/interactive-media-ads/media/stock.mp4",
              adTagUrl: "https://pubads.g.doubleclick.net/gampad/ads?iu=/21775744923/external/single_ad_samples&sz=640x480&cust_params=sample_ct%3Dlinear&ciu_szs=300x250%2C728x90&gdfp_req=1&output=vast&unviewed_position_start=1&env=vp&impl=s&correlator=", 
              adType: .postRoll),
        Media(id: 2, image: "vertical_image1", 
              name: "Mid-Roll",
              url: "https://storage.googleapis.com/interactive-media-ads/media/stock.mp4",
              adTagUrl: "https://pubads.g.doubleclick.net/gampad/ads?iu=/21775744923/external/single_ad_samples&sz=640x480&cust_params=sample_ct%3Dlinear&ciu_szs=300x250%2C728x90&gdfp_req=1&output=vast&unviewed_position_start=1&env=vp&impl=s&correlator=",
              adType: .midRoll),
//        Media(id: 3, image: "vertical_image1", name: "Media 3", url: "https://storage.googleapis.com/interactive-media-ads/media/stock.mp4", adTagUrl: "https://pubads.g.doubleclick.net/gampad/ads?iu=/21775744923/external/single_ad_samples&sz=640x480&cust_params=sample_ct%3Dlinear&ciu_szs=300x250%2C728x90&gdfp_req=1&output=vast&unviewed_position_start=1&env=vp&impl=s&correlator=", adType: .preRoll),
//        Media(id: 4, image: "vertical_image1", name: "Media 4", url: "https://storage.googleapis.com/interactive-media-ads/media/stock.mp4", adTagUrl: "https://pubads.g.doubleclick.net/gampad/ads?iu=/21775744923/external/single_ad_samples&sz=640x480&cust_params=sample_ct%3Dlinear&ciu_szs=300x250%2C728x90&gdfp_req=1&output=vast&unviewed_position_start=1&env=vp&impl=s&correlator=", adType: .preRoll),
//        Media(id: 5, image: "vertical_image1", name: "Media 5", url: "https://storage.googleapis.com/interactive-media-ads/media/stock.mp4", adTagUrl: "https://pubads.g.doubleclick.net/gampad/ads?iu=/21775744923/external/single_ad_samples&sz=640x480&cust_params=sample_ct%3Dlinear&ciu_szs=300x250%2C728x90&gdfp_req=1&output=vast&unviewed_position_start=1&env=vp&impl=s&correlator=", adType: .preRoll),
//        Media(id: 6, image: "vertical_image1", name: "Media 6", url: "https://storage.googleapis.com/interactive-media-ads/media/stock.mp4", adTagUrl: "https://pubads.g.doubleclick.net/gampad/ads?iu=/21775744923/external/single_ad_samples&sz=640x480&cust_params=sample_ct%3Dlinear&ciu_szs=300x250%2C728x90&gdfp_req=1&output=vast&unviewed_position_start=1&env=vp&impl=s&correlator=", adType: .preRoll),
//        Media(id: 7, image: "vertical_image1", name: "Media 7", url: "https://storage.googleapis.com/interactive-media-ads/media/stock.mp4", adTagUrl: "https://pubads.g.doubleclick.net/gampad/ads?iu=/21775744923/external/single_ad_samples&sz=640x480&cust_params=sample_ct%3Dlinear&ciu_szs=300x250%2C728x90&gdfp_req=1&output=vast&unviewed_position_start=1&env=vp&impl=s&correlator=", adType: .preRoll),
//        Media(id: 8, image: "vertical_image1", name: "Media 8", url: "https://storage.googleapis.com/interactive-media-ads/media/stock.mp4", adTagUrl: "https://pubads.g.doubleclick.net/gampad/ads?iu=/21775744923/external/single_ad_samples&sz=640x480&cust_params=sample_ct%3Dlinear&ciu_szs=300x250%2C728x90&gdfp_req=1&output=vast&unviewed_position_start=1&env=vp&impl=s&correlator=", adType: .preRoll),
//        Media(id: 9, image: "vertical_image1", name: "Media 9", url: "https://storage.googleapis.com/interactive-media-ads/media/stock.mp4", adTagUrl: "https://pubads.g.doubleclick.net/gampad/ads?iu=/21775744923/external/single_ad_samples&sz=640x480&cust_params=sample_ct%3Dlinear&ciu_szs=300x250%2C728x90&gdfp_req=1&output=vast&unviewed_position_start=1&env=vp&impl=s&correlator=", adType: .preRoll),
    ]
    
    static let mediahorizontalElements = [
        Media(id: 0, image: "horizontal_image1",
              name: "Pre-Roll",
              url: "https://storage.googleapis.com/interactive-media-ads/media/stock.mp4",
              adTagUrl: "https://pubads.g.doubleclick.net/gampad/ads?iu=/21775744923/external/single_ad_samples&sz=640x480&cust_params=sample_ct%3Dlinear&ciu_szs=300x250%2C728x90&gdfp_req=1&output=vast&unviewed_position_start=1&env=vp&impl=s&correlator=",
              adType: .preRoll),
        Media(id: 1, image: "horizontal_image1", 
              name: "Post-Roll",
              url: "https://storage.googleapis.com/interactive-media-ads/media/stock.mp4",
              adTagUrl: "https://pubads.g.doubleclick.net/gampad/ads?iu=/21775744923/external/single_ad_samples&sz=640x480&cust_params=sample_ct%3Dlinear&ciu_szs=300x250%2C728x90&gdfp_req=1&output=vast&unviewed_position_start=1&env=vp&impl=s&correlator=",
              adType: .postRoll),
        Media(id: 2, image: "horizontal_image1",
              name: "Mid-Roll",
              url: "https://storage.googleapis.com/interactive-media-ads/media/stock.mp4",
              adTagUrl: "https://pubads.g.doubleclick.net/gampad/ads?iu=/21775744923/external/single_ad_samples&sz=640x480&cust_params=sample_ct%3Dlinear&ciu_szs=300x250%2C728x90&gdfp_req=1&output=vast&unviewed_position_start=1&env=vp&impl=s&correlator=",
              adType: .midRoll),
//        Media(id: 3, image: "horizontal_image1", name: "Media 3", url: "https://storage.googleapis.com/interactive-media-ads/media/stock.mp4", adTagUrl: "https://pubads.g.doubleclick.net/gampad/ads?iu=/21775744923/external/single_ad_samples&sz=640x480&cust_params=sample_ct%3Dlinear&ciu_szs=300x250%2C728x90&gdfp_req=1&output=vast&unviewed_position_start=1&env=vp&impl=s&correlator=", adType: .preRoll),
//        Media(id: 4, image: "horizontal_image1", name: "Media 4", url: "https://storage.googleapis.com/interactive-media-ads/media/stock.mp4", adTagUrl: "https://pubads.g.doubleclick.net/gampad/ads?iu=/21775744923/external/single_ad_samples&sz=640x480&cust_params=sample_ct%3Dlinear&ciu_szs=300x250%2C728x90&gdfp_req=1&output=vast&unviewed_position_start=1&env=vp&impl=s&correlator=", adType: .preRoll),
//        Media(id: 5, image: "horizontal_image1", name: "Media 5", url: "https://storage.googleapis.com/interactive-media-ads/media/stock.mp4", adTagUrl: "https://pubads.g.doubleclick.net/gampad/ads?iu=/21775744923/external/single_ad_samples&sz=640x480&cust_params=sample_ct%3Dlinear&ciu_szs=300x250%2C728x90&gdfp_req=1&output=vast&unviewed_position_start=1&env=vp&impl=s&correlator=", adType: .preRoll),
//        Media(id: 6, image: "horizontal_image1", name: "Media 6", url: "https://storage.googleapis.com/interactive-media-ads/media/stock.mp4", adTagUrl: "https://pubads.g.doubleclick.net/gampad/ads?iu=/21775744923/external/single_ad_samples&sz=640x480&cust_params=sample_ct%3Dlinear&ciu_szs=300x250%2C728x90&gdfp_req=1&output=vast&unviewed_position_start=1&env=vp&impl=s&correlator=", adType: .preRoll),
//        Media(id: 7, image: "horizontal_image1", name: "Media 7", url: "https://storage.googleapis.com/interactive-media-ads/media/stock.mp4", adTagUrl: "https://pubads.g.doubleclick.net/gampad/ads?iu=/21775744923/external/single_ad_samples&sz=640x480&cust_params=sample_ct%3Dlinear&ciu_szs=300x250%2C728x90&gdfp_req=1&output=vast&unviewed_position_start=1&env=vp&impl=s&correlator=", adType: .preRoll),
//        Media(id: 8, image: "horizontal_image1", name: "Media 8", url: "https://storage.googleapis.com/interactive-media-ads/media/stock.mp4", adTagUrl: "https://pubads.g.doubleclick.net/gampad/ads?iu=/21775744923/external/single_ad_samples&sz=640x480&cust_params=sample_ct%3Dlinear&ciu_szs=300x250%2C728x90&gdfp_req=1&output=vast&unviewed_position_start=1&env=vp&impl=s&correlator=", adType: .preRoll),
//        Media(id: 9, image: "horizontal_image1", name: "Media 9", url: "https://storage.googleapis.com/interactive-media-ads/media/stock.mp4", adTagUrl: "https://pubads.g.doubleclick.net/gampad/ads?iu=/21775744923/external/single_ad_samples&sz=640x480&cust_params=sample_ct%3Dlinear&ciu_szs=300x250%2C728x90&gdfp_req=1&output=vast&unviewed_position_start=1&env=vp&impl=s&correlator=", adType: .preRoll),
    ]
}

import KeychainAccess
class Utils {
    
    private let keychainKey = "com.charbelyoussef.mangomolo"
    private let keychain = Keychain(service: "com.charbelyoussef")
    
    
    // MARK: - Keychain Methods
    /// Save the checkbox value to keychain for onAppear retrieval
    public func saveCheckBoxValueToKeychain(_ value: Bool) {
        do {
            try keychain.set(value ? "true" : "false", key: keychainKey)
        } catch {
            print("Error saving to Keychain: \(error)")
        }
    }
    
    /// Retrieve the checkbox value from keychain onAppear of Homepage view
    public func loadCheckBoxValueFromKeychain() -> Bool {
        do {
            if let value = try keychain.get(keychainKey) {
                return (value == "true")
            }
        } catch {
            print("Error loading from Keychain: \(error)")
            return false
        }
        return false
    }
}

