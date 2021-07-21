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
            self.itemContentLabel.text = item.content
            self.priceLabel.text = item.priceFormat
        }
    }
    
    private let itemImageView:BaseImageView = {
        let imageView:BaseImageView = BaseImageView()
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 15
        
        return imageView
    }()
    
    private let itemNameLabel:BaseLabel = BaseLabel()
    
    private let itemContentLabel:BaseLabel = BaseLabel()
    
    private let priceLabel:BaseLabel = BaseLabel()
    
    private let heartLabel:BaseLabel = BaseLabel()
    
    // MARK: - Life Cycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubviews(views: [
            self.itemImageView, self.itemNameLabel,
            self.itemContentLabel, self.priceLabel
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
            self.itemImageView.widthAnchor.constraint(equalToConstant: 100),
            self.itemImageView.heightAnchor.constraint(equalToConstant: 100),
            self.itemImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10),

            self.itemNameLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10),
            self.itemNameLabel.leadingAnchor.constraint(equalTo: self.itemImageView.trailingAnchor, constant: 15),
            self.itemNameLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -10),
            
            self.itemContentLabel.topAnchor.constraint(equalTo: self.itemNameLabel.bottomAnchor, constant: 10),
            self.itemContentLabel.leadingAnchor.constraint(equalTo: self.itemImageView.trailingAnchor, constant: 15),
            self.itemContentLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -10),
            
            self.priceLabel.topAnchor.constraint(equalTo: self.itemContentLabel.bottomAnchor, constant: 10),
            self.priceLabel.leadingAnchor.constraint(equalTo: self.itemImageView.trailingAnchor, constant: 15),
            self.priceLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -10),
            self.priceLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -15),
        ])
    }
    
    override func bind() {
        
    }
}
