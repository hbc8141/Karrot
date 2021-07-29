//
//  Seller.swift
//  Karrot
//
//  Created by User on 2021/07/27.
//

import Foundation

struct Seller: Codable {
    let sellerId: Int
    let imageUrl: String
    let name: String
    let location: String
    let temperature: Float
    
    init() {
        sellerId = 0
        imageUrl = "https://s3.ap-northeast-2.amazonaws.com/img.kormedi.com/news/article/__icsFiles/artimage/2015/02/12/c_km601/645985_540.jpg"
        name = "고길동"
        location = "신월동 양구2동"
        temperature = 34.12
    }
}
