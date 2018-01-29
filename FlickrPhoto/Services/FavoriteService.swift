//
//  FavoriteService.swift
//  FlickrPhoto
//
//  Created by Li Zhao on 1/28/18.
//  Copyright © 2018 Li Zhao. All rights reserved.
//

import Foundation

class FavoritesService: NSObject {
    var favoritedPhotos = [String]()
    override init() {
        super.init()
        getFavorites { (true) in
            return
        }
    }

    func getFavorites(_ complition: @escaping (Bool) -> Void) {
        let para = ["api_key" : APIKey,
                    "method" : "flickr.favorites.getList",
                    "format" : "json",
                    "user_id" : NSID,
                    "nojsoncallback" : "1"] as [String: Any]
        HttpsService().postRequest(EndPoint, para) { (json) in
            if let json = json {
                print(json)
            }
        }
    }

    public func addFavorites(_ photoID: String) {
        if favoritedPhotos.contains(photoID) {
            return
        }
        favoritedPhotos.append(photoID)
        addFavoritesFromServer(photoID)
    }

    public func isFavoritedPhoto(_ photoID: String) -> Bool {
        return favoritedPhotos.contains(photoID)
    }

    public func removeFavorites(_ photoID: String) {
        if !favoritedPhotos.contains(photoID) {
            return
        }
        favoritedPhotos.remove(at: favoritedPhotos.index(of: photoID)!)
        removeFavoriteFromServer(photoID)
    }

    fileprivate func removeFavoriteFromServer(_ photoID: String) {
        let para = ["api_key" : APIKey,
                    "photo_id": photoID,
                    "format" : "json",
                    "method" : "flickr.favorites.remove"] as [String: Any]
        HttpsService().postRequest(EndPoint, para) { (json) in
            if let json = json {
                print(json)
            }
        }
    }

    fileprivate func addFavoritesFromServer(_ photoID: String) {
        let para = ["api_key" : APIKey,
                    "photo_id": photoID,
                    "format" : "json",
                    "nojsoncallback" : "1",
                    "method" : "flickr.favorites.add"] as [String: Any]
        HttpsService().postRequest(EndPoint, para) { (json) in
            if let json = json {
                print(json)
            }
        }
    }
}
