//
//  FeedModel.swift
//  InstaClient
//
//  Created by Ruslan Nikolaev on 05/11/2017.
//  Copyright © 2017 Ruslan Nikolaev. All rights reserved.
//

import Foundation
import UIKit.UIImage

class FeedModel {
    
    // MARK: Private variables
    
    private let feedService: InstaFeedServiceInterface
    private let sessionService: InstaSessionServiceInterface
    
    // MARK: Initialization
    
    init(feedService: InstaFeedServiceInterface = InstaFeedService(),
         sessionService: InstaSessionServiceInterface = InstaSessionService()) {
        
        self.feedService = feedService
        self.sessionService = sessionService
    }
    
    // MARK: Public methods
    
    public func canFetchFeed() -> Bool {
        return self.sessionService.sessionAvailable()
    }
    
    public func fetchFeed(userId: String?, result: @escaping FeedCompletion) {
        self.feedService.fetchFeed(userId: userId, nextPageId: nil, result: result)
    }
    
    public func loadMore(userId: String?, nextPageId: String, result: @escaping FeedCompletion) {
        self.feedService.fetchFeed(userId: userId, nextPageId: nextPageId, result: result)
    }
    
    public func postImageWithUrl(url: URL) -> UIImage {
        return UIImage(named: "placeholder")!
    }
    
    public func clearFeed() {
        self.sessionService.invalidateSession()
    }
}
