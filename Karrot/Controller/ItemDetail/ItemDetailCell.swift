//
//  ItemDetailCell.swift
//  Karrot
//
//  Created by User on 2021/07/27.
//

import UIKit

class ItemDetailCell: BaseTableViewCell {

    // MARK: - Properties
    private let innerView:BaseView = BaseView()

    private let titleLabel:BaseLabel = BaseLabel()

    private let categoryAndCreateTimeLabel:BaseLabel = BaseLabel()

    private let contentLabel:BaseLabel = BaseLabel()
    
    // MARK: - Life Cycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(self.innerView)

        self.innerView.addSubviews(views: [
            self.titleLabel,
            self.categoryAndCreateTimeLabel,
            self.contentLabel
        ])
        
        self.setupLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Function
    override func setupLayouts() {
        NSLayoutConstraint.activate([
            self.innerView.topAnchor.constraint(equalTo: self.topAnchor, constant: 25),
            self.innerView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 25),
            self.innerView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 25),
            self.innerView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -25),

            self.titleLabel.topAnchor.constraint(equalTo: self.innerView.topAnchor),
            self.titleLabel.leadingAnchor.constraint(equalTo: self.innerView.leadingAnchor),
            self.titleLabel.trailingAnchor.constraint(equalTo: self.innerView.trailingAnchor),
            self.titleLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 0),
            
            self.categoryAndCreateTimeLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor),
            self.categoryAndCreateTimeLabel.leadingAnchor.constraint(equalTo: self.innerView.leadingAnchor),
            self.categoryAndCreateTimeLabel.trailingAnchor.constraint(equalTo: self.innerView.trailingAnchor),
            self.categoryAndCreateTimeLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 0),
            
            self.contentLabel.topAnchor.constraint(equalTo: self.innerView.topAnchor),
            self.contentLabel.leadingAnchor.constraint(equalTo: self.innerView.leadingAnchor),
            self.contentLabel.trailingAnchor.constraint(equalTo: self.innerView.trailingAnchor),
            self.contentLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 0),
        ])
    }
}
