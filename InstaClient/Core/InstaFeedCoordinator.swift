//
//  InstaFeedCoordinator.swift
//  InstaClient
//
//  Created by Ruslan Nikolaev on 05/11/2017.
//  Copyright © 2017 Ruslan Nikolaev. All rights reserved.
//

import UIKit

fileprivate let kStoryboardName = "Feed"
fileprivate let kFeedVcName = "FeedViewController"

class InstaFeedCoordinator {

    // MARK: Initialization
    
    init() {
        
    }
    
    // MARK: Public methods
    
    public func initialViewController() -> UINavigationController? {
        
        let storyboard = UIStoryboard(name: kStoryboardName, bundle: nil)
        
        guard let feedVc = storyboard.instantiateViewController(withIdentifier: kFeedVcName) as? FeedViewController else {
            assertionFailure("\(kFeedVcName) not found in \(kStoryboardName)")
            return nil;
        }
        
        let navigationVc = UINavigationController(rootViewController: feedVc)
        return navigationVc
    }
}
