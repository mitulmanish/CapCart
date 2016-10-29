//
//  PriceFormatter.swift
//  CapCart
//
//  Created by Mitul Manish on 29/10/2016.
//  Copyright © 2016 Mitul Manish. All rights reserved.
//

import Foundation

class PriceFormatter {
    
    public static func convert(price: String) -> String {
        
        let priceNumberArray = price.characters.map { String($0) }
        var filteredPriceNumberArray = priceNumberArray.filter{$0 != " " && $0 != "-"}
        
        if filteredPriceNumberArray.count > 3 {
            let splitIndex = 2
            var modifiedPriceNumber = ""
            var counter = 1
            
            for index in 0..<filteredPriceNumberArray.count {
                modifiedPriceNumber += filteredPriceNumberArray[index]
                counter += 1
                if (counter % splitIndex == 0) && ((index + 2) != filteredPriceNumberArray.count) && ((index + 2) < filteredPriceNumberArray.count) {
                    modifiedPriceNumber += ","
                }
            }
            return modifiedPriceNumber
        }
        return price
    }
}
