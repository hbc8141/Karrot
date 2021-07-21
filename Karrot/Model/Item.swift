//
//  Item.swift
//  Karrot
//
//  Created by User on 2021/07/16.
//

import Foundation
import FontAwesome_swift

struct Item: Codable {
    let title:String
    let content:String
    let imageUrl:String
    let price:Int
    let msgAndHeart:MsgAndHeart?
    
    var priceFormat:String {
        let formatter:NumberFormatter = NumberFormatter()
        formatter.numberStyle = .decimal
        
        let currencyPrice:NSNumber = NSNumber(value: price)
        
        let priceString:String = formatter.string(from: currencyPrice) ?? "0"
        
        return "\(priceString) 원"
    }
}

struct MsgAndHeart: Codable {
    let msgCnt:Int?
    let heartCnt:Int?

    // MARK: - Function
    // 메세지 및 관심 글자 반환
    func msgAndHeartText() -> NSMutableAttributedString? {
        let mutableAttrString:NSMutableAttributedString = NSMutableAttributedString()
        
        // 메세지 개수
        if let msgCnt:Int = self.msgCnt {
            let font:UIFont = UIFont.fontAwesome(ofSize: 15, style: .regular)
            let msgIcon:String = String.fontAwesomeIcon(name: .comment)
            let attrString:NSAttributedString = NSAttributedString(string: "\(msgIcon) \(msgCnt) ", attributes: [
                .font : font,
                .foregroundColor: UIColor.black
            ])
            
            mutableAttrString.append(attrString)
        }
        
        // 관심 개수
        if let heartCnt:Int = self.heartCnt {
            let font:UIFont = UIFont.fontAwesome(ofSize: 15, style: .regular)
            let heartIcon:String = String.fontAwesomeIcon(name: .heart)
            let attrString:NSAttributedString = NSAttributedString(string: "\(heartIcon) \(heartCnt) ", attributes: [
                .font : font,
                .foregroundColor: UIColor.black
            ])
            
            mutableAttrString.append(attrString)
        }

        return mutableAttrString.length > 0 ? mutableAttrString : nil
    }
}
