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
    
//    public func sizeForData(_ data: FeedItem) -> CGSize {
//
//        let string = data.text
//        let left = self.captionLabel.constraints.filter({$0.firstAttribute == .leading}).first?.constant ?? 0
//        let right = self.captionLabel.constraints.filter({$0.firstAttribute == .trailing}).first?.constant ?? 0
//
//        let size = string.boundingRect(with: CGSize(width: self.bounds.width - (left+right), height: CGFloat.greatestFiniteMagnitude),
//                                       options: .usesFontLeading,
//                                       attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 15)],
//                                       context: nil).size
//        let contentHeight = CGFloat(301)
//
//        return CGSize(width: self.frame.width, height: contentHeight + size.height)
//    }
}
