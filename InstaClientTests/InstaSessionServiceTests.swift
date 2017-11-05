//
//  InstaSessionServiceTests.swift
//  InstaClientTests
//
//  Created by Ruslan Nikolaev on 05/11/2017.
//  Copyright © 2017 Ruslan Nikolaev. All rights reserved.
//

import XCTest
import InstagramKit

class InstaSessionServiceTests: XCTestCase {
    
    func testSessionAvailability() {
        
        let engine = EngineMock()
        engine.sessionValid = false
        
        let service = InstaSessionService(sdkEngine: engine)
        XCTAssert(service.sessionAvailable() == false)
        
        engine.sessionValid = true
        XCTAssert(service.sessionAvailable() == true)
    }
    
    func testSessionInvalidation() {
        
        let engine = EngineMock()
        engine.sessionValid = true
        
        let service = InstaSessionService(sdkEngine: engine)
        service.invalidateSession()
        
        XCTAssert(service.sessionAvailable() == false)
    }
    
    class EngineMock: InstagramEngine {
        
        public var sessionValid = false
        
        override func isSessionValid() -> Bool {
            return sessionValid
        }
        
        override func logout() {
            self.sessionValid = false
        }
    }
}
