//
//  CollectionViewCell.swift
//  FlickrPhoto
//
//  Created by Li Zhao on 1/25/18.
//  Copyright © 2018 Li Zhao. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    var favorited = false
    var photoData: PhotoData! {
        didSet {
            if photoData != nil {
                imageView.setImage(with: photoData.flickrImageURL())
            }
        }
    }
    @IBAction func tappedButton(_ sender: UIButton) {
        favorited = !favorited
        if favorited {
            sender.setImage(#imageLiteral(resourceName: "start_fill").withRenderingMode(.alwaysTemplate), for: .normal)
        } else {
            sender.setImage(#imageLiteral(resourceName: "start"), for: .normal)
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .white
        favoriteButton.imageView?.tintColor = .red
    }
}
