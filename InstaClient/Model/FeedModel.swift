//
//  FeedModel.swift
//  InstaClient
//
//  Created by Ruslan Nikolaev on 05/11/2017.
//  Copyright © 2017 Ruslan Nikolaev. All rights reserved.
//

import Foundation

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
        
        self.feedService.fetchFeed(userId: userId, result: result)
    }
    
    public func clearFeed() {
        
        self.sessionService.invalidateSession()
    }
}
