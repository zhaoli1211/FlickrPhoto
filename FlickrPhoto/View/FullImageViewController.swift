//
//  FullImageViewController.swift
//  FlickrPhoto
//
//  Created by Li Zhao on 1/26/18.
//  Copyright © 2018 Li Zhao. All rights reserved.
//

import UIKit

class FullImageViewController: UIViewController {

    var imageView: UIImageView!
    var imageURL: URL!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupImageView()
        setupCloseButton()
        self.edgesForExtendedLayout = []
        self.extendedLayoutIncludesOpaqueBars = false
        self.automaticallyAdjustsScrollViewInsets = false
    }

    func setupImageView() {
        imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight))
        imageView.backgroundColor = .lightGray
        imageView.contentMode = .scaleAspectFit
        imageView.setImage(with: imageURL)
        view.addSubview(imageView)
    }

    func setupCloseButton() {
        let closeButton = UIButton(frame: CGRect(x: 0, y: 20, width: 44, height: 44))
        closeButton.setTitle("X", for: .normal)
        closeButton.setTitleColor(.black, for: .normal)
        closeButton.addTarget(self, action: #selector(close), for: .touchUpInside)
        view.addSubview(closeButton)
        view.bringSubview(toFront: closeButton)
    }

    @objc func close() {
        self.dismiss(animated: true, completion: nil)
    }
}
