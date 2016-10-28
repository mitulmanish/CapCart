//
//  Constants.swift
//  CapCart
//
//  Created by Mitul Manish on 28/10/2016.
//  Copyright © 2016 Mitul Manish. All rights reserved.
//

import Foundation


enum EndPoint: String {
    
    case hat = "products.json"
    
    var value: String {
        return self.rawValue
    }
}

struct Constants {
    struct HatShop {
        static let baseUrl = "http://wemakeapps.net/hats/"
    }
}
