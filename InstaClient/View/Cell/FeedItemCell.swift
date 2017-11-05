//
//  FeedItemCell.swift
//  InstaClient
//
//  Created by Ruslan Nikolaev on 05/11/2017.
//  Copyright © 2017 Ruslan Nikolaev. All rights reserved.
//

import UIKit

class FeedItemCell: UITableViewCell {

    // MARK: IBOutlets
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var thumbImageView: UIImageView!
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var favCountLabel: UILabel!
    
    // MARK: Public methods
    
    public func setData(_ data: FeedItem) {
        
        self.nameLabel.text = data.author
        self.captionLabel.text = data.text
        self.favCountLabel.text = "\(data.likesCount)"
    }
    
    public func updateImage(image: UIImage) {
        self.thumbImageView.image = image
    }
}
