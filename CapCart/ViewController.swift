//
//  ViewController.swift
//  CapCart
//
//  Created by Mitul Manish on 27/10/2016.
//  Copyright © 2016 Mitul Manish. All rights reserved.
//

import UIKit
import Alamofire

class Seller {
    let id: Int?
    let name: String?
    
    init(data: [String: AnyObject]) {
        
        print("Seller info")
        if let id = data["id"] as? Int {
            print(id)
            self.id = id
        } else {
            self.id = nil
        }
        
        if let name = data["name"] as? String {
            print(name)
            self.name = name
        } else {
            self.name = nil
        }
    }
}

class Product {
    
    let id: Int?
    let title: String?
    let sizes: [String]?
    let description: String?
    let price: Int?
    let imageUrl: URL?
    let productSeller: Seller?
    
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
    
    init(data: [String: AnyObject]) {
        
        if let id = data["id"] as? Int {
            print(id)
            self.id = id
        } else {
            self.id = nil
        }
        
        if let title = data["title"] as? String {
            print(title)
            self.title = title
        } else {
            self.title = nil
        }
        
        if let sizes = data["sizes"] as? [String] {
            print(sizes)
            self.sizes = sizes
        } else {
            self.sizes = nil
        }
        
        if let description = data["description"] as? String {
            print(description)
            self.description = description
        } else {
            self.description = nil
        }
        
        if let price = data["price"] as? Int {
            print(price)
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
    
    var productAsList: [AnyObject?] {
        return [self.productImage, self.title as Optional<AnyObject>, self.price as Optional<AnyObject>, self.description as Optional<AnyObject>, self.sizes as Optional<AnyObject>, self.productSeller]
    }
    
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        fetchDataFromService(url: "http://wemakeapps.net/hats/products.json") { (dictionary) in
            var products: [Product] = []
            
            if let productList = dictionary["products"] as? [[String: AnyObject]] {
                for product in productList {
                    products.append(Product(data: product))
                }
            }
            print(products.count)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func fetchDataFromService(url: String, completionHandler: @escaping ([String: AnyObject]) -> ()) {
        Alamofire.request("http://wemakeapps.net/hats/products.json").responseJSON { (dataResponse) in
            if let jsonData = dataResponse.result.value {
                if let dictionary = jsonData as? [String: AnyObject] {
                    completionHandler(dictionary)
                }
            }
        }
    }
}

