//
//  ItemCell.swift
//  Karrot
//
//  Created by User on 2021/07/16.
//

import Foundation
import UIKit

class ItemCell: BaseTableViewCell {
    
    // MARK: - Properties
    var item:Item? {
        didSet {
            guard let item:Item = item else { return }
            
            self.itemNameLabel.text = item.title
            self.addrAndTradeLocLabel.text = item.content
            self.priceLabel.text = item.priceFormat
            
            if let mainImageUrl:String = item.imageUrl.first {
                self.itemImageView.loadImage(absoluteUrl: mainImageUrl)
            }
            
            if let msgAndHeart:MsgAndHeart = item.msgAndHeart {
                self.msgAndHeartLabel.attributedText = msgAndHeart.msgAndHeartText()
            } else {
                self.msgAndHeartLabel.attributedText = nil
            }
        }
    }
    
    private let itemImageView:BaseImageView = {
        let imageView:BaseImageView = BaseImageView()
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 15
        
        return imageView
    }()
    
    private let itemNameLabel:BaseLabel = BaseLabel()
    
    private let addrAndTradeLocLabel:BaseLabel = BaseLabel()
    
    private let priceLabel:BaseLabel = BaseLabel()
    
    private let msgAndHeartLabel:BaseLabel = {
        let label:BaseLabel = BaseLabel()
        label.textAlignment = .right
        
        return label
    }()
    
    // MARK: - Life Cycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubviews(views: [
            self.itemImageView, self.itemNameLabel,
            self.addrAndTradeLocLabel, self.priceLabel, self.msgAndHeartLabel
        ])
        
        setupLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Function
    override func setupLayouts() {
        NSLayoutConstraint.activate([
            self.itemImageView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            self.itemImageView.widthAnchor.constraint(equalToConstant: 130),
            self.itemImageView.heightAnchor.constraint(equalToConstant: 130),
            self.itemImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10),

            self.itemNameLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10),
            self.itemNameLabel.leadingAnchor.constraint(equalTo: self.itemImageView.trailingAnchor, constant: 15),
            self.itemNameLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -10),
            self.itemNameLabel.bottomAnchor.constraint(equalTo: self.addrAndTradeLocLabel.bottomAnchor, constant: 10),
            
            self.addrAndTradeLocLabel.heightAnchor.constraint(equalToConstant: 25),
            self.addrAndTradeLocLabel.bottomAnchor.constraint(equalTo: self.priceLabel.topAnchor, constant: 10),
            self.addrAndTradeLocLabel.leadingAnchor.constraint(equalTo: self.itemImageView.trailingAnchor, constant: 15),
            self.addrAndTradeLocLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -10),
            
            self.priceLabel.heightAnchor.constraint(equalToConstant: 50),
            self.priceLabel.leadingAnchor.constraint(equalTo: self.itemImageView.trailingAnchor, constant: 15),
            self.priceLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -10),
            self.priceLabel.bottomAnchor.constraint(greaterThanOrEqualTo: self.msgAndHeartLabel.topAnchor, constant: 15),
            
            self.msgAndHeartLabel.heightAnchor.constraint(equalToConstant: 25),
            self.msgAndHeartLabel.leadingAnchor.constraint(equalTo: self.itemImageView.trailingAnchor, constant: 15),
            self.msgAndHeartLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -10),
            self.msgAndHeartLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -15)
        ])
    }
    
    override func bind() {
        
    }
}
