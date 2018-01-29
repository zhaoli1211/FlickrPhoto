//
//  HttpsService.swift
//  FlickrPhoto
//
//  Created by Li Zhao on 1/24/18.
//  Copyright © 2018 Li Zhao. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class HttpsService {
    func postRequest(_ url: URL, _ parameter: [String: Any]?, complition: @escaping (JSON?) -> Void){
        Alamofire.request(url,
                          method: .post,
                          parameters: parameter)
            .responseJSON { (response) in
                guard response.result.isSuccess else {
                    print("Error when getting search result \(response.result.error!)")
                    complition(nil)
                    return
                }
                guard let value = response.result.value else {
                    print("Data formate is wrong")
                    complition(nil)
                    return
                }
                return complition(JSON(value))
        }
    }
}
