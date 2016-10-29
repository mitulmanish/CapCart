//
//  Product.swift
//  CapCart
//
//  Created by Mitul Manish on 29/10/2016.
//  Copyright © 2016 Mitul Manish. All rights reserved.
//

import Foundation
import UIKit

class Product {
    
    let id: Int?
    let title: String?
    let sizes: [String]?
    let description: String?
    let price: Int?
    let imageUrl: URL?
    let productSeller: Seller?
    
    init(data: [String: AnyObject]) {
        
        if let id = data["id"] as? Int {
            self.id = id
        } else {
            self.id = nil
        }
        
        if let title = data["title"] as? String {
            self.title = title
        } else {
            self.title = nil
        }
        
        if let sizes = data["sizes"] as? [String] {
            self.sizes = sizes
        } else {
            self.sizes = nil
        }
        
        if let description = data["description"] as? String {
            self.description = description
        } else {
            self.description = nil
        }
        
        if let price = data["price"] as? Int {
            self.price = price
        } else {
            self.price = nil
        }
        
        if let imageURL = data["imageUrl"] as? String {
            self.imageUrl = URL(string: imageURL)
        } else {
            self.imageUrl = nil
        }
        
        if let seller = data["seller"] as? [String: AnyObject] {
            self.productSeller = Seller(data: seller)
        } else {
            self.productSeller = nil
        }
    }
    var productImage: UIImage? {
        get {
            do {
                if let url = self.imageUrl {
                    let imageData = try Data(contentsOf: url)
                    return UIImage(data: imageData)
                } else {
                    return nil
                }
            } catch {
                return nil
            }
        }
    }
    
    var prettyPrintedProductPrice: String {
        return "$ \(self.price)"
    }
    
    var productAsList: [AnyObject?] {
        return [self.productImage, self.title as Optional<AnyObject>, self.price as Optional<AnyObject>, self.description as Optional<AnyObject>, self.sizes as Optional<AnyObject>, self.productSeller]
    }
    
    var textToShare: String? {
        guard let productTitle = self.title, let productDescription = self.description else {
            return nil
        }
        return productTitle + " - " + productDescription
    }
}
