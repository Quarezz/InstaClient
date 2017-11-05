//
//  AppDelegate.swift
//  InstaClient
//
//  Created by Ruslan Nikolaev on 05/11/2017.
//  Copyright © 2017 Ruslan Nikolaev. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    // MARK: Public variables
    
    var window: UIWindow?
    
    // MARK: Private variables
    
    private let flowCoordinator = InstaFeedCoordinator()
    
    // MARK: UIApplicationDelegate
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        if (NSClassFromString("XCTest") != nil)
        {
            return true
        }
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = self.flowCoordinator.initialViewController()
        self.window?.makeKeyAndVisible()
        
        return true
    }
}

