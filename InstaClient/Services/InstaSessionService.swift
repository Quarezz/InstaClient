//
//  InstaSessionServiceInterface.swift
//  InstaClient
//
//  Created by Ruslan Nikolaev on 05/11/2017.
//  Copyright © 2017 Ruslan Nikolaev. All rights reserved.
//

import UIKit
import InstagramKit

class InstaSessionService: InstaSessionServiceInterface {

    // MARK: Private variables
    
    private let instaEngine: InstagramEngine
    
    // MARK: Initialization
    
    init(sdkEngine: InstagramEngine = InstagramEngine.shared()) {
        self.instaEngine = sdkEngine
    }
    
    // MARK: InstaSessionServiceInterface
    
    func sessionAvailable() -> Bool {
        return self.instaEngine.isSessionValid()
    }
    
    func invalidateSession() {
        self.instaEngine.logout()
    }
}
