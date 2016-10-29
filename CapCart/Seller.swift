//
//  Seller.swift
//  CapCart
//
//  Created by Mitul Manish on 29/10/2016.
//  Copyright © 2016 Mitul Manish. All rights reserved.
//

import Foundation

class Seller {
    let id: Int?
    let name: String?
    
    init(data: [String: AnyObject]) {
        
        if let id = data["id"] as? Int {
            self.id = id
        } else {
            self.id = nil
        }
        
        if let name = data["name"] as? String {
            self.name = name
        } else {
            self.name = nil
        }
    }
}
