//
//  InstaFeedServiceInterface.swift
//  InstaClient
//
//  Created by Ruslan Nikolaev on 05/11/2017.
//  Copyright © 2017 Ruslan Nikolaev. All rights reserved.
//

import Foundation

enum FeedFetchResult {
    case success(feed: [FeedItem])
    case fail(reason: String)
}

protocol InstaFeedServiceInterface {
    
    func fetchFeed(userId: String, result: FeedFetchResult)
}
