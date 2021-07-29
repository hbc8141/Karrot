//
//  UserCell.swift
//  Karrot
//
//  Created by User on 2021/07/27.
//

import UIKit

class UserCell: BaseTableViewCell {

    // MARK: - Properties
    var seller:Seller? {
        didSet {
            guard let seller:Seller = seller else { return }
            self.userProfileImageView.loadImage(absoluteUrl: seller.imageUrl)
            self.userNameLabel.text = seller.name
            self.userLocationLabel.text = seller.location
        }
    }
    
    private let userProfileImageView:BaseImageView = {
        let imageView:BaseImageView = BaseImageView()
        imageView.layer.cornerRadius = 25
        imageView.layer.masksToBounds = true
        
        return imageView
    }()

    private let userNameLabel:BaseLabel = BaseLabel()

    private let userLocationLabel:BaseLabel = BaseLabel()

    private let celsiusLabel:BaseLabel = BaseLabel()

    private let progressView:BaseProgressView = BaseProgressView()
    
    private let celsiusIconLabel:BaseLabel = BaseLabel()
    
    private let mannerTemperatureButton:BaseButton = BaseButton()

    // MARK: - Life Cycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubviews(views: [
            self.userProfileImageView,
            self.userNameLabel,
            self.userLocationLabel,
            self.celsiusLabel,
            self.progressView
        ])
        
        self.setupLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Function
    override func setupLayouts() {
        NSLayoutConstraint.activate([
            self.userProfileImageView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            self.userProfileImageView.widthAnchor.constraint(equalToConstant: 50),
            self.userProfileImageView.heightAnchor.constraint(equalTo: self.userProfileImageView.widthAnchor),
            self.userProfileImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20),
            
            self.userNameLabel.topAnchor.constraint(equalTo: self.userProfileImageView.topAnchor),
            self.userNameLabel.leadingAnchor.constraint(equalTo: self.userProfileImageView.trailingAnchor, constant: 15),
            self.userNameLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -20),
            self.userNameLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 0),
            
            self.userLocationLabel.topAnchor.constraint(equalTo: self.userNameLabel.bottomAnchor, constant: 5),
            self.userLocationLabel.leadingAnchor.constraint(equalTo: self.userProfileImageView.trailingAnchor, constant: 15),
            self.userLocationLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -20),
            self.userLocationLabel.bottomAnchor.constraint(equalTo: self.userProfileImageView.bottomAnchor)
        ])
    }
}
