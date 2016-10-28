//
//  DataFormatter.swift
//  CapCart
//
//  Created by Mitul Manish on 28/10/2016.
//  Copyright © 2016 Mitul Manish. All rights reserved.
//

import Foundation

struct DataFormatter {
    static func getListOfProducts(data: [String: AnyObject]) -> [Product] {
        var products: [Product] = []
        
        if let productList = data["products"] as? [[String: AnyObject]] {
            for product in productList {
                products.append(Product(data: product))
            }
        }
        return products
    }
}
