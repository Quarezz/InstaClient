//
//  FeedModel.swift
//  InstaClient
//
//  Created by Ruslan Nikolaev on 05/11/2017.
//  Copyright © 2017 Ruslan Nikolaev. All rights reserved.
//

import Foundation
import UIKit.UIImage

class FeedModel {
    
    // MARK: Private variables
    
    private let feedService: InstaFeedServiceInterface
    private let sessionService: InstaSessionServiceInterface
    private let imageCacheService: ImageCacheService
    private var imagesLoadingQueue: OperationQueue
    private var imagesAwaitCallback: ((URL, UIImage)->Void)?
    
    // MARK: Initialization
    
    init(feedService: InstaFeedServiceInterface = InstaFeedService(),
         sessionService: InstaSessionServiceInterface = InstaSessionService(),
         imageCacheService: ImageCacheService = ImageCacheService(maxSize: 1024 * 1024 * 25)) {
        
        self.feedService = feedService
        self.sessionService = sessionService
        self.imageCacheService = imageCacheService
        self.imagesLoadingQueue = OperationQueue()
        self.imagesLoadingQueue.maxConcurrentOperationCount = 5
    }
    
    deinit {
        
        self.imagesLoadingQueue.cancelAllOperations()
        self.imagesAwaitCallback = nil
        self.imageCacheService.clear()
    }
    
    // MARK: Public methods
    
    public func canFetchFeed() -> Bool {
        return self.sessionService.sessionAvailable()
    }
    
    public func fetchFeed(userId: String?, result: @escaping FeedCompletion) {
        self.feedService.fetchFeed(userId: userId, nextPageId: nil, result: result)
    }
    
    public func loadMore(userId: String?, nextPageId: String, result: @escaping FeedCompletion) {
        self.feedService.fetchFeed(userId: userId, nextPageId: nextPageId, result: result)
    }
    
    public func awaitForImageUpdates(callback: @escaping (URL,UIImage)->Void) {
        self.imagesAwaitCallback = callback
    }
    
    public func postImageWithUrl(url: URL) -> UIImage {
        
        if let image = self.imageCacheService.getImage(forUrl: url.absoluteString) {
            return image
        }
        else {
            
            self.imagesLoadingQueue.addOperation {
                
                URLSession.shared.dataTask(with: url, completionHandler: { (data, _, _) in
                    
                    if let data = data, let image = UIImage(data: data) {
                        self.imageCacheService.add(image: image, forUrl: url.absoluteString)
                        
                        DispatchQueue.main.async {
                            self.imagesAwaitCallback?(url, image)
                        }
                    }
                }).resume()
            }
            
            return UIImage(named: "placeholder")!
        }
    }
    
    public func clearFeed() {
        self.sessionService.invalidateSession()
    }
}
