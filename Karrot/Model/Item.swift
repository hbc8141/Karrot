//
//  Item.swift
//  Karrot
//
//  Created by User on 2021/07/16.
//

import Foundation

struct Item: Codable {
    let title:String
    let content:String
    let imageUrl:String
    let price:Int
    let heart:Int?
    
    var priceFormat:String {
        let formatter:NumberFormatter = NumberFormatter()
        formatter.numberStyle = .decimal
        
        let currencyPrice:NSNumber = NSNumber(value: price)
        
        let priceString:String = formatter.string(from: currencyPrice) ?? "0"
        
        return "\(priceString) 원"
    }
}
