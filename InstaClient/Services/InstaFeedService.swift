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

fileprivate let kPageCount = 20;

class InstaFeedService: NSObject, InstaFeedServiceInterface {

    // MARK: Private variables
    
    private let instaEngine: InstagramEngine
    private var authUrl: URL?
    private var result: FeedCompletion?
    
    // MARK: Initialization
    
    init(sdkEngine: InstagramEngine = InstagramEngine.shared()) {
        
        self.instaEngine = sdkEngine
    }
    
    // MARK: InstaFeedServiceInterface
    
    func fetchFeed(userId: String?, nextPageId: String?, result: @escaping (FeedFetchResult) -> Void) {
        
        if let userId = userId, !userId.isEmpty {
            
            self.instaEngine.getMediaForUser(userId, count: kPageCount, maxId: nextPageId, withSuccess: {(media, info) in
                
                print("Received feed: \(media)")
                let feed = media.map({ FeedItem(id: $0.id,
                                                author: $0.user.username,
                                                text: $0.caption?.text ?? "",
                                                imageUrl: $0.thumbnailURL,
                                                likes: $0.likesCount) })
                result(FeedFetchResult.success(feed: feed, nextPageId: info.nextMaxId))
                
            }, failure: { (error, code) in
                
                if code == 400 {
                    result(FeedFetchResult.fail(reason: "User doesn't exist"))
                }
                else {
                    result(FeedFetchResult.fail(reason: error.localizedDescription))
                }
            })
        }
        else {
            
            self.instaEngine.getSelfRecentMedia(withCount: kPageCount, maxId: nextPageId, success: {(media, info) in
                
                print("Received feed: \(media)")
                let feed = media.map({ FeedItem(id: $0.id,
                                                author: $0.user.username,
                                                text: $0.caption?.text ?? "",
                                                imageUrl: $0.thumbnailURL,
                                                likes: $0.likesCount) })
                result(FeedFetchResult.success(feed: feed, nextPageId: info.nextMaxId))
                
            }, failure: { (error, code) in
                
                result(FeedFetchResult.fail(reason: error.localizedDescription))
            })
        }
    }
}
