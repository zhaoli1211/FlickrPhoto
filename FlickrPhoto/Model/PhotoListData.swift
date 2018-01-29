//
//  PhotoListData.swift
//  FlickrPhoto
//
//  Created by Li Zhao on 1/25/18.
//  Copyright © 2018 Li Zhao. All rights reserved.
//

import Foundation

struct PhotoListData {
    var photoList: [PhotoData]!
    var total: Int?
    var perpage: Int?
    var page: Int?
    var pages: Int?
    var favortiesData = false

    init(_ photoList: [PhotoData], _ total: Int?, _ perpage: Int?, _ page: Int?, _ pages: Int?) {
        self.photoList = photoList
        self.total = total
        self.perpage = perpage
        self.page = page
        self.pages = pages
    }
}
