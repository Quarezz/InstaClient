//
//  InstaFeedService.swift
//  InstaClient
//
//  Created by Ruslan Nikolaev on 05/11/2017.
//  Copyright © 2017 Ruslan Nikolaev. All rights reserved.
//

import Foundation
import SafariServices
import InstagramKit

class InstaFeedService: NSObject, InstaFeedServiceInterface {

    // MARK: Private variables
    
    private let instaEngine: InstagramEngine
    private var authUrl: URL?
    private var result: FeedCompletion?
    
    // MARK: Initialization
    
    init(sdkEngine: InstagramEngine = InstagramEngine.shared()) {
        
        self.instaEngine = sdkEngine
    }
    
    // MARK: Private methods
    
    private func authorize(userId: String?) {
        
//        self.authSession = SFAuthenticationSession(url: self.authUrl!, callbackURLScheme: "testschema://", completionHandler: { [weak self] (url, error) in
//
//            guard let strongSelf = self else {
//                return
//            }
//
//            guard error == nil else {
//                strongSelf.result?(FeedFetchResult.fail(reason: error!.localizedDescription))
//                return
//            }
//            guard let url = url else {
//                strongSelf.result?(FeedFetchResult.fail(reason: "Unable to authorize"))
//                return
//            }
//
//            do {
//                try strongSelf.instaEngine.receivedValidAccessToken(from: url)
//                strongSelf.fetchAuthorizedFeed(userId: userId, result: strongSelf.result!)
//            }
//            catch {
//                strongSelf.result?(FeedFetchResult.fail(reason: error.localizedDescription))
//            }
//
//        })
//        self.authSession?.start()
    }
    
    private func fetchAuthorizedFeed(userId: String?, result: @escaping (FeedFetchResult) -> Void) {
        
        if let userId = userId, !userId.isEmpty {
            
            self.instaEngine.getMediaForUser(userId, withSuccess: {(media, info) in
                
                let feed = media.map({ FeedItem(id: $0.id,
                                                text: $0.caption?.text ?? "",
                                                imageUrl: $0.thumbnailURL) })
                result(FeedFetchResult.success(feed: feed))
                
            }, failure: { (error, code) in
                
                result(FeedFetchResult.fail(reason: error.localizedDescription))
            })
        }
        else {
            
            self.instaEngine.getSelfRecentMedia(success: {(media, info) in
                
                let feed = media.map({ FeedItem(id: $0.id,
                                                text: $0.caption?.text ?? "",
                                                imageUrl: $0.thumbnailURL) })
                result(FeedFetchResult.success(feed: feed))
                
            }, failure: { (error, code) in
                
                result(FeedFetchResult.fail(reason: error.localizedDescription))
            })
        }
    }
    
    // MARK: InstaFeedServiceInterface
    
    func fetchFeed(userId: String?, result: @escaping (FeedFetchResult) -> Void) {
        
        guard self.instaEngine.accessToken != nil else {
            
            self.result = result
            self.authUrl = self.instaEngine.authorizationURL(for: .publicContent)
            self.authorize(userId: userId)
            return
        }
        
        self.fetchAuthorizedFeed(userId: userId, result: result)
    }
}
