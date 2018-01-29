//
//  HomeViewController.swift
//  FlickrPhoto
//
//  Created by Li Zhao on 1/24/18.
//  Copyright © 2018 Li Zhao. All rights reserved.
//

import UIKit

enum UIUserInterfaceIdiom : Int {
    case unspecified
    case phone
    case pad
}

class HomeViewController: UIViewController {

    var collectionView: UICollectionView!
    var searchController: UISearchController!
    var homeModel: HomeViewModel! {
        didSet {
            if homeModel != nil {
                homeModel.searchedPhotos.bindAndFire({ (data) in
                    self.collectionView.reloadData()
                })
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setSearchBar()
        homeModel = HomeViewModel()
    }

    func setSearchBar() {
        self.searchController = UISearchController(searchResultsController:  nil)
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Search Photos"
        definesPresentationContext = true
        self.searchController.hidesNavigationBarDuringPresentation = false
        self.navigationItem.titleView = searchController.searchBar
    }

    @objc func changeFavorited(_ sender: UIButton) {
        let photo = homeModel.getPhotoByIndex(sender.tag)
        homeModel.updateFavorites(photo.id)
    }

    func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        switch UIDevice.current.userInterfaceIdiom {
        case .pad:
            layout.itemSize = CGSize(width: (ScreenWidth - 20) / 2, height: (ScreenWidth - 20) / 2)
        case .phone: layout.itemSize = CGSize(width: ScreenWidth, height: ScreenWidth)
        default: layout.itemSize = CGSize(width: ScreenWidth, height: ScreenWidth)
        }

        layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        var frame = self.view.frame
        frame.origin.y += 40
        frame.size.height -= 40
        collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.registerCell(CollectionViewCell.self)
        collectionView.backgroundColor = UIColor(red: 250, green: 250, blue: 250, alpha: 1.0)
        view.addSubview(collectionView)
    }
}

// MARK UICollectionViewDelegate
extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = FullImageViewController()
        vc.imageURL = homeModel.getPhotoByIndex(indexPath.row).flickrImageURL()
        self.present(vc, animated: true, completion: nil)
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row + 1 == homeModel.totalPhotos() && !homeModel.loading {
            homeModel.getPhotos()
        }
    }
}

// MARK UICollectionViewDataSource
extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return homeModel.totalPhotos()
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(CollectionViewCell.self, for: indexPath)
        cell.photoData = homeModel.getPhotoByIndex(indexPath.row)
        cell.favoriteButton.tag = indexPath.row
        cell.favoriteButton.addTarget(self, action: #selector(changeFavorited(_:)), for: .touchUpInside)
        return cell
    }
}

// MARK UISearchBarDelegate
extension HomeViewController: UISearchBarDelegate {
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        if let term = searchBar.text, term.count != 0 {
            homeModel.getPhotos(term)
        }
        return true
    }
}


