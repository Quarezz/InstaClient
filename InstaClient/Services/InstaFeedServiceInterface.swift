//
//  InstaFeedServiceInterface.swift
//  InstaClient
//
//  Created by Ruslan Nikolaev on 05/11/2017.
//  Copyright © 2017 Ruslan Nikolaev. All rights reserved.
//

import Foundation
import UIKit.UIWebView

enum FeedFetchResult {
    case success(feed: [FeedItem], nextPageId: String?)
    case fail(reason: String)
}

typealias FeedCompletion = (_ result: FeedFetchResult) -> Void

protocol InstaFeedServiceInterface {
    
    /// Fetch instagramm feed for specified user
    /// - parameter userId: identifier of instagramm user. If nil - current user is used
    /// - parameter pageId: id of next page
    /// - parameter result: completion block with result state
    func fetchFeed(userId: String?, nextPageId: String?, result: @escaping FeedCompletion)
}
