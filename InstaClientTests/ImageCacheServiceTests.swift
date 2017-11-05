//
//  ImageCacheServiceTests.swift
//  InstaClientTests
//
//  Created by Ruslan Nikolaev on 05/11/2017.
//  Copyright © 2017 Ruslan Nikolaev. All rights reserved.
//

import XCTest

class ImageCacheServiceTests: XCTestCase {
    
    let bundle = Bundle(for: ImageCacheServiceTests.self)
    
    func testEmptyCache() {
        
        let cache = ImageCacheService(maxSize: 1024 * 1024 * 25)
        XCTAssert(cache.getAllImages().count == 0)
        XCTAssert(cache.getImage(forUrl: "foo") == nil)
    }
    
    func testNonEmptyCache() {
        
        let cache = ImageCacheService(maxSize: 1024 * 1024 * 25)

        let image1 = UIImage(named: "testImage.jpg", in: bundle, compatibleWith: nil)
        cache.add(image: image1!, forUrl: "test1")
        XCTAssert(cache.getAllImages().count == 1)
        XCTAssert(cache.getImage(forUrl: "test1") == image1)
        
        let image2 = UIImage(named: "testImage.jpg", in: bundle, compatibleWith: nil)
        cache.add(image: image2!, forUrl: "test2")
        XCTAssert(cache.getAllImages().count == 2)
        XCTAssert(cache.getImage(forUrl: "test2") == image2)
    }
    
    func testMemoryBounds() {
        
        var image = UIImage(named: "testImage.jpg", in: bundle, compatibleWith: nil)
        let imageSize = UIImageJPEGRepresentation(image!, 1)!.count
        let cache = ImageCacheService(maxSize: imageSize * 5)
        
        for i in 0..<5 {
            
            image = UIImage(named: "testImage.jpg", in: bundle, compatibleWith: nil)
            cache.add(image: image!, forUrl: "\(i)")
        }
        
        XCTAssert(cache.getAllImages().count == 5)
        
        image = UIImage(named: "testImage.jpg", in: bundle, compatibleWith: nil)
        cache.add(image: image!, forUrl: "new")
        
        XCTAssert(cache.getAllImages().count == 5)
    }
    
    func testDoubleAdding() {
        
        let cache = ImageCacheService(maxSize: 1024 * 1024 * 25)
        
        let image1 = UIImage(named: "testImage.jpg", in: bundle, compatibleWith: nil)
        cache.add(image: image1!, forUrl: "foo")
        
        let image2 = UIImage(named: "testImage.jpg", in: bundle, compatibleWith: nil)
        cache.add(image: image2!, forUrl: "foo")
        
        XCTAssert(cache.getAllImages().count == 1)
    }
    
    func testClearingCache() {
    
        let cache = ImageCacheService(maxSize: 1024 * 1024 * 25)
        
        let image1 = UIImage(named: "testImage.jpg", in: bundle, compatibleWith: nil)
        cache.add(image: image1!, forUrl: "test1")
        cache.clear()
        
        XCTAssert(cache.getAllImages().count == 0)
    }
}
