//
//  UserCell.swift
//  Karrot
//
//  Created by User on 2021/07/27.
//

import UIKit

class UserCell: BaseTableViewCell {

    // MARK: - Properties
    private let userProfileImageView:BaseImageView = BaseImageView()

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
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Function

}
