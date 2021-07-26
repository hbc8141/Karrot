//
//  ItemImageCell.swift
//  Karrot
//
//  Created by User on 2021/07/20.
//

import UIKit

class ItemImageCollectionViewCell: BaseCollectionViewCell {
    
    // MARK: - Properties
    var imageUrl:String? {
        didSet {
            guard let imageUrl:String = imageUrl else { return }
            
            self.itemImageView.loadImage(absoluteUrl: imageUrl)
        }
    }

    private let itemImageView:BaseImageView = BaseImageView()
    
    // MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.contentView.addSubviews(views: [
            self.itemImageView
        ])
        
        self.setupLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Function
    override func setupLayouts() {
        NSLayoutConstraint.activate([
            self.itemImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.itemImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.itemImageView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            self.itemImageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
        ])
    }
}
