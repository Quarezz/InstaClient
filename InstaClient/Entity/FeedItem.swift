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
    public let author: String
    public var text: String?
    public let imageUrl: URL
    public let likesCount: Int
    
    // MARK: Initialization
    
    init(id: String, author: String, text: String?, imageUrl: URL, likes: Int) {
        
        self.identifier = id
        self.author = author
        self.text = text
        self.imageUrl = imageUrl
        self.likesCount = likes
        
        super.init()
    }
}
