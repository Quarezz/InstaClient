//
//  LoginModel.swift
//  InstaClient
//
//  Created by Ruslan Nikolaev on 05/11/2017.
//  Copyright © 2017 Ruslan Nikolaev. All rights reserved.
//

import UIKit.UIWebView
import InstagramKit

class LoginModel: NSObject, UIWebViewDelegate {
    
    // MARK: Private variables
    
    private let instaEngine: InstagramEngine
    private var completion: ((_ error: String?) -> Void)?
    
    // MARK: Initialization
    
    init(instaEngine: InstagramEngine = InstagramEngine.shared()) {
        
        self.instaEngine = instaEngine
    }
    
    // MARK: Public methods
    
    public func login(webView: UIWebView, completion: @escaping (_ error: String?) -> Void) {
        
        self.completion = completion
        webView.loadRequest(URLRequest(url: self.instaEngine.authorizationURL()))
    }
    
    // MARK: UIWebViewDelegate
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
 
        guard let url = request.url?.absoluteString, url.hasPrefix(self.instaEngine.appRedirectURL) else {
            return true
        }
        
        do {
            
            try self.instaEngine.receivedValidAccessToken(from: request.url!)
            self.completion?(nil)
        }
        catch {
            self.completion?(error.localizedDescription)
        }
        return false;
    }
}
