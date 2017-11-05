//
//  FeedViewController.swift
//  InstaClient
//
//  Created by Ruslan Nikolaev on 05/11/2017.
//  Copyright © 2017 Ruslan Nikolaev. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

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
    private var currentUserId: String?
    private var nextPageId: String?
    private var lastContentOffsetY = CGFloat(0)
    
    // MARK: Overriden
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.register(UINib(nibName: "FeedItemCell", bundle: nil), forCellReuseIdentifier: "FeedItemCell")
        
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
        
        self.currentUserId = self.idTextField.text
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
        
        self.feedModel.fetchFeed(userId: self.currentUserId, result: { [weak self] (result) in
            
            switch (result) {
            case .success(let feed, let nextPageId):
                
                self?.feed = feed
                self?.nextPageId = nextPageId
                self?.tableView.reloadData()
                break
            case .fail(let reason):
                
                self?.showError(error: reason)
                break
            }
        })
    }
    
    private func loadMore() {
        
        self.feedModel.loadMore(userId: self.currentUserId, nextPageId: self.nextPageId!, result: { [weak self] (result) in
            
            guard let strongSelf = self else { return }
            
            switch (result) {
            case .success(let feed, let nextPageId):
                
                strongSelf.feed.append(contentsOf: feed)
                strongSelf.nextPageId = nextPageId
                self?.tableView.reloadData()
                break
            case .fail(let reason):
                
                strongSelf.showError(error: reason)
                break
            }
        })
    }
    
    private func showError(error: String) {
     
        let alert = UIAlertController(title: nil, message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK: UITableViewDelegate
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if let cell = cell as? FeedItemCell {
            
            let post = self.feed[indexPath.row]
            cell.updateImage(image: feedModel.postImageWithUrl(url: post.imageUrl))
        }
        
        if (indexPath.row == self.feed.count - 1) {
            self.loadMore()
        }
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    // MARK: UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.feed.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FeedItemCell") as? FeedItemCell else {
            fatalError("FeedItemCell not registered")
        }
        
        cell.setData(self.feed[indexPath.row])
        return cell
    }
}
