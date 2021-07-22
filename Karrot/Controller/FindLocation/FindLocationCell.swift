//
//  FindLocationCell.swift
//  Karrot
//
//  Created by User on 2021/07/21.
//

import UIKit

class FindLocationCell: BaseTableViewCell {

    // MARK: - Properties
    var findStreet:FindStreet? {
        didSet {
            guard let findStreet:FindStreet = findStreet else { return }
            
            self.mainStreetLabel.text = findStreet.mainStreet
            
            if let subStreet:String = findStreet.subStreet {
                self.subStreetLabel.text = "관련주소 : \(subStreet)"
            } else {
                self.subStreetLabel.text = nil
            }
        }
    }
    
    private let mainStreetLabel:BaseLabel = BaseLabel()

    private let subStreetLabel:BaseLabel = {
        let label:BaseLabel = BaseLabel(textColor: .gray)
        label.font = label.font.withSize(12)
        
        return label
    }()

    // MARK: - Life Cycles
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubviews(views: [
            self.mainStreetLabel, self.subStreetLabel
        ])
        
        self.setupLayouts()
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
            self.mainStreetLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 0),
            
            self.subStreetLabel.topAnchor.constraint(equalTo: self.mainStreetLabel.bottomAnchor, constant: 5),
            self.subStreetLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 5),
            self.subStreetLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -5),
            self.subStreetLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 0)
        ])
    }
}
