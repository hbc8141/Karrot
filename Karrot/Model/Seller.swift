//
//  Seller.swift
//  Karrot
//
//  Created by User on 2021/07/27.
//

import Foundation

struct Seller: Codable {
    let sellerId: Int
    let name: String
    let location: String
    let temperature: Float
    
    init() {
        sellerId = 0
        name = "고길동"
        location = "신월동 양구2동"
        temperature = 34.12
    }
}
