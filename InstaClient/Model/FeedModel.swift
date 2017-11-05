//
//  FeedModel.swift
//  InstaClient
//
//  Created by Ruslan Nikolaev on 05/11/2017.
//  Copyright © 2017 Ruslan Nikolaev. All rights reserved.
//

import UIKit

class FeedModel {

    // MARK: Private variables
    
    private let feedService: InstaFeedServiceInterface
    
    // MARK: Initialization
    
    init(feedService: InstaFeedServiceInterface = InstaFeedService()) {
        
        self.feedService = feedService
    }
    
    // MARK:
}
