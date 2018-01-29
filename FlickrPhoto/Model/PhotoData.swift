//
//  PhotoData.swift
//  FlickrPhoto
//
//  Created by Li Zhao on 1/24/18.
//  Copyright © 2018 Li Zhao. All rights reserved.
//

import Foundation

struct PhotoData {
    var id: String!
    var farm: String!
    var title: String!
    var secret: String!
    var server: String!

    init(_ id: String, _ farm: String, _ title: String, _ secret: String, _ server: String) {
        self.id = id
        self.farm = farm
        self.title = title
        self.secret = secret
        self.server = server
    }

        // build photot url
    func flickrImageURL(_ size:String = "m") -> URL? {
        if let farm = farm, let server = server, let id = id , let secret = secret {
            if let url =  URL(string:  "https://farm\(farm).staticflickr.com/\(server)/\(id)_\(secret)_\(size).jpg") {
                return url
            }
        }
        return nil
    }

}

