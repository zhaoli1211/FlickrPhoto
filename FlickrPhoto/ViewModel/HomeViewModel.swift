//
//  HomeViewModel.swift
//  FlickrPhoto
//
//  Created by Li Zhao on 1/24/18.
//  Copyright © 2018 Li Zhao. All rights reserved.
//

import Foundation
import SwiftyJSON

class  HomeViewModel {
    var searchedPhotos: Dynamic<PhotoListData?>
    var loading = false
    var previousTerm = ""
    var page = 1 // page number of the total pages
    var favoritesService: FavoritesService!

    init() {
        self.searchedPhotos = Dynamic(nil)
        favoritesService = FavoritesService()
    }

        //earch photos by term
    func getPhotos(_ term: String = "") {
        loading = true
        if let value = searchedPhotos.value {
                // change if it reaches the last page
            page = value.pages! > value.page! + 1 ? value.page! + 1 : value.pages!
        }

        if term != "" {
                // clear the data if user entners new term
            searchedPhotos.value = nil
            page = 1
            previousTerm = term
        } else if previousTerm == "" {
            return
        }

        let para = ["api_key" : APIKey,
                    "method" : "flickr.photos.search",
                    "format" : "json",
                    "text" : previousTerm,
                    "nojsoncallback" : "1",
                    "page" : page,
                    "per_page" : "20"] as [String: Any]

        HttpsService().postRequest(EndPoint, para) { (json) in
            if let json = json {
                if var value = self.searchedPhotos.value {
                    value.page! += 1
                    value.photoList! += self.fromJSON(json: json).photoList
                    self.searchedPhotos.value = value
                } else {
                    self.searchedPhotos.value = self.fromJSON(json: json)
                }
            }
            self.loading = false
        }
    }

    func totalPhotos() -> Int {
        if let photos = searchedPhotos.value {
            return photos.photoList.count
        }
        return 0
    }

    func getPhotoByIndex(_ index: Int) -> PhotoData {
        return searchedPhotos.value!.photoList[index]
    }

    func updateFavorites(_ photoID: String) {
        if isFavoritedPhoto(photoID) {
            favoritesService.removeFavorites(photoID)
        } else {
            favoritesService.addFavorites(photoID)
        }
    }

    func isFavoritedPhoto(_ photoID: String) -> Bool {
        return favoritesService.isFavoritedPhoto(photoID)
    }

    func fromJSON(json: JSON) -> PhotoListData {

        let photosData = json["photos"].dictionaryValue
        var photoList = [PhotoData]()
        if let photos = photosData["photo"]?.arrayValue {
            for photo in photos {
                let id = photo["id"].stringValue
                let farm = photo["farm"].stringValue
                let server = photo["server"].stringValue
                let secret = photo["secret"].stringValue
                let title = photo["title"].stringValue
                let temp = PhotoData(id, farm, title, secret, server)
                photoList.append(temp)
            }
        }
        let total = photosData["total"]?.intValue
        let perpage = photosData["perpage"]?.intValue
        let page = photosData["page"]?.intValue
        let pages = photosData["pages"]?.intValue
        return PhotoListData(photoList, total, perpage, page, pages)
    }
}
