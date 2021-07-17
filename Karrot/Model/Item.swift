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
}
