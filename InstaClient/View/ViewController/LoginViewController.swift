//
//  LoginViewController.swift
//  InstaClient
//
//  Created by Ruslan Nikolaev on 05/11/2017.
//  Copyright © 2017 Ruslan Nikolaev. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    // MARK: Public variables
    
    public var coordinator: InstaFeedCoordinator?
    
    // MARK: IBOutlets
    
    @IBOutlet weak var webView: UIWebView!
    
    // MARK: Private variables
    
    private let loginModel = LoginModel()

    // MARK: Overriden
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .done, target: self, action: #selector(tappedBack))
        self.webView.delegate = self.loginModel
        
        self.loginModel.login(webView: self.webView) {[weak self] (error) in
            
            guard let strongSelf = self else { return }
            
            if error != nil {
                
                let alert = UIAlertController(title: nil, message: error, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { (_) in
                    
                    strongSelf.coordinator?.finishLoginFlow(callerVc: strongSelf)
                }))
                strongSelf.present(alert, animated: true, completion: nil)
            }
            else {
                strongSelf.coordinator?.finishLoginFlow(callerVc: strongSelf)
            }
        }
    }
    
    // MARK: Actions
    
    @objc private func tappedBack() {
        self.coordinator?.finishLoginFlow(callerVc: self)
    }
}
