//
//  UICollectionView-Extension.swift
//  FlickrPhoto
//
//  Created by Li Zhao on 1/25/18.
//  Copyright © 2018 Li Zhao. All rights reserved.
//

import Foundation
import UIKit

extension UICollectionView {

    func registerCell(_ class: UICollectionViewCell.Type) {
        register(UINib(nibName: String(describing: `class`), bundle: nil),
                 forCellWithReuseIdentifier: String(describing: `class`))
    }

    func dequeueCell<T: UICollectionViewCell>(_ class: T.Type, for indexPath: IndexPath) -> T {
        return dequeueReusableCell(withReuseIdentifier: String(describing: `class`), for: indexPath) as! T
    }
}
