//
//  HatShopService.swift
//  CapCart
//
//  Created by Mitul Manish on 28/10/2016.
//  Copyright © 2016 Mitul Manish. All rights reserved.
//

import Foundation
import Alamofire

class HatShopService {
    
    var baseUrl: String
    static let sharedInstance = HatShopService()
    
    private init() {
        self.baseUrl = Constants.HatShop.baseUrl
    }
    
    func getDataFromService(endPoint: EndPoint, completionHandler: @escaping ([String: AnyObject]) -> ()) {
        Alamofire.request(self.baseUrl + endPoint.value).responseJSON { (dataResponse) in
            if let jsonData = dataResponse.result.value {
                if let dictionary = jsonData as? [String: AnyObject] {
                    completionHandler(dictionary)
                }
            }
        }
    }
}
