//
//  FeedItem.swift
//  InstaClient
//
//  Created by Ruslan Nikolaev on 05/11/2017.
//  Copyright © 2017 Ruslan Nikolaev. All rights reserved.
//

import UIKit

class FeedItem: NSObject {

    // MARK: Public variables
    
    public let identifier: String
    public let text: String
    public let imageUrl: URL
    
    // MARK: Initialization
    
    init(id: String, text: String, imageUrl: URL) {
        
        self.identifier = id
        self.text = text
        self.imageUrl = imageUrl
        super.init()
    }
}
