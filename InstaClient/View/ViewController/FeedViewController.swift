//
//  FeedViewController.swift
//  InstaClient
//
//  Created by Ruslan Nikolaev on 05/11/2017.
//  Copyright © 2017 Ruslan Nikolaev. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController {

    // MARK: Public variables
    
    public var coordinator: InstaFeedCoordinator?
    
    // MARK: IBOutlets
    
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var userInputView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Private variables
    
    private var loginButton: UIBarButtonItem?
    private var logoutButton: UIBarButtonItem?
    
    private let feedModel = FeedModel()
    private var feed = [FeedItem]()
    
    // MARK: Overriden
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.loginButton = UIBarButtonItem(title: "Login", style: .done, target: self, action: #selector(tappedLogin))
        self.logoutButton = UIBarButtonItem(title: "Logout", style: .done, target: self, action: #selector(tappedLogout))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if self.feedModel.canFetchFeed() {
            
            self.updateFeedAvailability(canFetch: true)
            if self.feed.isEmpty {
                self.fetchFeed()
            }
        }
        else {
            self.updateFeedAvailability(canFetch: false)
        }
    }
    
    // MARK: IBActions
    
    @IBAction func tappedFetch(_ sender: Any) {
        self.fetchFeed()
    }
    
    // MARK: Actions
    
    @objc func tappedLogin() {
        self.coordinator?.startLoginFlow(callerVc: self)
    }
    
    @objc func tappedLogout() {
        
        self.feedModel.clearFeed()
        self.updateFeedAvailability(canFetch: false)
    }
    
    // MARK: Private methods
    
    private func updateFeedAvailability(canFetch: Bool) {
        
        if canFetch {
            
            self.navigationItem.leftBarButtonItem = self.logoutButton
            self.tableView.isHidden = false
            self.userInputView.isHidden = false
        }
        else {
            
            self.navigationItem.leftBarButtonItem = self.loginButton
            self.tableView.isHidden = true
            self.userInputView.isHidden = true
        }
    }
    
    private func fetchFeed() {
        
        self.feedModel.fetchFeed(userId: self.idTextField.text, result: { (result) in
            
            switch (result) {
            case .success(let feed):
                self.feed = feed
                break
            case .fail(let reason):
                self.showError(error: reason)
                break
            }
        })
    }
    
    private func showError(error: String) {
     
        let alert = UIAlertController(title: nil, message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
