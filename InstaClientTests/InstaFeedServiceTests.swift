//
//  InstaFeedServiceTests.swift
//  InstaClientTests
//
//  Created by Ruslan Nikolaev on 05/11/2017.
//  Copyright © 2017 Ruslan Nikolaev. All rights reserved.
//

import XCTest
import InstagramKit

class InstaFeedServiceTests: XCTestCase {
    
    func testFetchingUserFeed() {
    
        let engine = EngineMock()
        engine.returnSelfEmptyFeed = false
        let service = InstaFeedService(sdkEngine: engine)
        
        let expectation = self.expectation(description: "userFeed")
        service.fetchFeed(userId: nil, nextPageId: nil) { (result) in
            
            switch result {
            case .fail(_):
                XCTAssert(false, "Should return success")
                break
            case .success(let feed, _):
                XCTAssert(feed.isEmpty == false, "Should have non-empty feed")
            }
            expectation.fulfill()
        }
        self.waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testFetchingCustomUserFeed() {
        
        let engine = EngineMock()
        engine.returnCustomEmptyFeed = false
        let service = InstaFeedService(sdkEngine: engine)
        
        let expectation = self.expectation(description: "customUserFeed")
        service.fetchFeed(userId: "foo", nextPageId: nil) { (result) in
            
            switch result {
            case .fail(_):
                XCTAssert(false, "Should return success")
                break
            case .success(let feed, _):
                XCTAssert(feed.isEmpty == false, "Should have non-empty feed")
            }
            expectation.fulfill()
        }
        self.waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testFetchingFirstPage() {
        
        let engine = EngineMock()
        engine.firstPageKey = "0"
        engine.secondPageKey = "1"
        let service = InstaFeedService(sdkEngine: engine)
        
        let expectation = self.expectation(description: "userFirstPage")
        service.fetchFeed(userId: nil, nextPageId: "0") { (result) in
            
            switch result {
            case .fail(_):
                XCTAssert(false, "Should return success")
                break
            case .success(let feed, _):
                XCTAssertTrue(feed.count == 3, "Should return first page with 3 elements")
            }
            expectation.fulfill()
        }
        self.waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testFetchingCustomPage() {
        
        let engine = EngineMock()
        engine.firstPageKey = "0"
        engine.secondPageKey = "1"
        let service = InstaFeedService(sdkEngine: engine)
        
        let expectation = self.expectation(description: "userSecondPage")
        service.fetchFeed(userId: nil, nextPageId: "1") { (result) in
            
            switch result {
            case .fail(_):
                XCTAssert(false, "Should return success")
                break
            case .success(let feed, _):
                XCTAssertTrue(feed.count == 2, "Should return second page with 3 elements")
            }
            expectation.fulfill()
        }
        self.waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testFailure() {
        
        let engine = EngineMock()
        engine.errorResponse = true
        let service = InstaFeedService(sdkEngine: engine)
        
        let expectation = self.expectation(description: "errorResponse")
        service.fetchFeed(userId: nil, nextPageId: nil) { (result) in
            
            switch result {
            case .fail(_):
                XCTAssert(true, "Should return fail")
                break
            case .success(_, _):
                XCTAssert(false, "Should return fail")
            }
            expectation.fulfill()
        }
        self.waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testCustomUserFailure() {
        
        let engine = EngineMock()
        engine.errorResponse = true
        let service = InstaFeedService(sdkEngine: engine)
        
        let expectation = self.expectation(description: "errorResponse")
        service.fetchFeed(userId: "foo", nextPageId: nil) { (result) in
            
            switch result {
            case .fail(_):
                XCTAssert(true, "Should return fail")
                break
            case .success(_, _):
                XCTAssert(false, "Should return fail")
            }
            expectation.fulfill()
        }
        self.waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testCustomUserExistanceFail() {
        
        let engine = EngineMock()
        engine.errorResponse = true
        engine.errorCode = 400
        let service = InstaFeedService(sdkEngine: engine)
        
        let expectation = self.expectation(description: "errorResponse")
        service.fetchFeed(userId: "foo", nextPageId: nil) { (result) in
            
            switch result {
            case .fail(_):
                XCTAssert(true, "Should return fail")
                break
            case .success(_, _):
                XCTAssert(false, "Should return fail")
            }
            expectation.fulfill()
        }
        self.waitForExpectations(timeout: 1, handler: nil)
    }
    
    class EngineMock: InstagramEngine {
        
        public var returnSelfEmptyFeed = false
        public var returnCustomEmptyFeed = false
        
        public var firstPageKey: String?
        public var secondPageKey: String?
        
        public var errorResponse = false
        public var errorCode = 0
        
        let mediaDummie = InstagramMedia(info: [
            "images": [
                "thumbnail": [
                    "url": "http://foo.com",
                ]
            ],
            "link":"http://foo.com"
            ])
        
        override func getSelfRecentMedia(withCount count: Int, maxId: String?, success: @escaping InstagramMediaBlock, failure: InstagramFailureBlock? = nil) {
            
            if errorResponse {
                failure?(NSError(domain: "", code: 0, userInfo: nil), errorCode)
                return
            }
            
            if maxId != nil {
                
                let pages = [
                    self.firstPageKey!: [mediaDummie, mediaDummie, mediaDummie],
                    self.secondPageKey!: [mediaDummie, mediaDummie]
                ]
                success(pages[maxId!]!, InstagramPaginationInfo())
                return
            }
            
            if (returnSelfEmptyFeed)
            {
                success([InstagramMedia](), InstagramPaginationInfo())
            }
            else
            {
                success([mediaDummie], InstagramPaginationInfo())
            }
        }
        
        override func getMediaForUser(_ userId: String, count: Int, maxId: String?, withSuccess success: @escaping InstagramMediaBlock, failure: InstagramFailureBlock? = nil) {
            
            if errorResponse {
                failure?(NSError(domain: "", code: 0, userInfo: nil), errorCode)
                return
            }
            
            if (returnCustomEmptyFeed)
            {
                success([InstagramMedia](), InstagramPaginationInfo())
            }
            else
            {
                success([mediaDummie], InstagramPaginationInfo())
            }
        }
    }
}
