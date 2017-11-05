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
    case success(feed: [FeedItem])
    case fail(reason: String)
}

typealias FeedCompletion = (_ result: FeedFetchResult) -> Void

protocol InstaFeedServiceInterface {
    
    /// Fetch instagramm feed for specified user
    /// - parameter userId: identifier of instagramm user. If nil - current user is used
    /// - parameter inView: client viewController that will be used for SFSafariViewController presentation for login flow
    /// - parameter result: completion block with result state
    func fetchFeed(userId: String?, result: @escaping FeedCompletion)
}
