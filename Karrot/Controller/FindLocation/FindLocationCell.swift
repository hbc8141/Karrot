//
//  FindLocationCell.swift
//  Karrot
//
//  Created by User on 2021/07/21.
//

import UIKit

class FindLocationCell: BaseTableViewCell {

    // MARK: - Properties
    var location:FindStreet? {
        didSet {
            guard let location:FindStreet = location else { return }
            
            self.mainStreetLabel.text = location.mainStreet
            self.subStreetLabel.text = location.subStreet
        }
    }
    
    private let mainStreetLabel:BaseLabel = BaseLabel()

    private let subStreetLabel:BaseLabel = BaseLabel()

    // MARK: - Life Cycles
    init() {
        super.init(style: .default, reuseIdentifier: "cell")
        
        self.contentView.addSubviews(views: [
            self.mainStreetLabel, self.subStreetLabel
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Function
    override func setupLayouts() {
        NSLayoutConstraint.activate([
            self.mainStreetLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 5),
            self.mainStreetLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 5),
            self.mainStreetLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -5),
            self.mainStreetLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 5),
            
            self.subStreetLabel.topAnchor.constraint(equalTo: self.mainStreetLabel.topAnchor, constant: 5),
            self.subStreetLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 5),
            self.subStreetLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -5),
            self.subStreetLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 5),
        ])
    }
}
