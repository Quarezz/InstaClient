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
fileprivate let kLoginVcName = "LoginViewController"

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
        feedVc.coordinator = self
        
        let navigationVc = UINavigationController(rootViewController: feedVc)
        return navigationVc
    }
    
    public func startLoginFlow(callerVc: FeedViewController) {
        
        let storyboard = UIStoryboard(name: kStoryboardName, bundle: nil)
        
        guard let loginVc = storyboard.instantiateViewController(withIdentifier: kLoginVcName) as? LoginViewController else {
            assertionFailure("\(kLoginVcName) not found in \(kStoryboardName)")
            return;
        }
        loginVc.coordinator = self
        
        let navigationVc = UINavigationController(rootViewController: loginVc)
        callerVc.present(navigationVc, animated: true, completion: nil)
    }
    
    public func finishLoginFlow(callerVc: LoginViewController) {
        
        callerVc.dismiss(animated: true, completion: nil)
    }
}
