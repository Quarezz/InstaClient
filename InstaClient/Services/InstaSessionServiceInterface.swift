//
//  InstaSessionServiceInterface.swift
//  InstaClient
//
//  Created by Ruslan Nikolaev on 05/11/2017.
//  Copyright © 2017 Ruslan Nikolaev. All rights reserved.
//

import Foundation

protocol InstaSessionServiceInterface {
    
    func sessionAvailable() -> Bool
    func invalidateSession() 
}
