//
//  UIImageView-Extension.swift
//  FlickrPhoto
//
//  Created by Li Zhao on 1/25/18.
//  Copyright © 2018 Li Zhao. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

extension UIImageView {
    public func setImage(with: URL? = nil) {
        self.kf.setImage(with: with, placeholder: nil, options: nil,
                         progressBlock: nil, completionHandler: nil)
    }
}
