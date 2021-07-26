//
//  BaseButton.swift
//  Supermarket
//
//  Created by User on 2021/07/02.
//

import UIKit
import FontAwesome_swift

class BaseButton: UIButton {

    // MARK: - Initialization
    init(title: String? = nil, backgroundColor: UIColor? = .orange) {
        super.init(frame: .zero)

        self.translatesAutoresizingMaskIntoConstraints = false
        self.setTitle(title, for: .normal)
        self.backgroundColor = backgroundColor

        self.setCornerButton()
    }

    init(fontIcon: FontAwesome, style:FontAwesomeStyle, fontSize: CGFloat = 15) {
        super.init(frame: .zero)

        self.translatesAutoresizingMaskIntoConstraints = false
        self.titleLabel?.font = UIFont.fontAwesome(ofSize: fontSize, style: style)
        self.setTitle(String.fontAwesomeIcon(name: fontIcon), for: .normal)
        self.setTitleColor(.black, for: .normal)
        
        self.setCornerButton()
    }
    
    init(fontIcon: FontAwesome, style:FontAwesomeStyle, textColor:UIColor = .white, size: CGSize) {
        super.init(frame: .zero)

        self.translatesAutoresizingMaskIntoConstraints = false
        let iconImage:UIImage = UIImage.fontAwesomeIcon(name: fontIcon, style: style, textColor: textColor, size: size)
        
        self.setImage(iconImage, for: .normal)
        self.setImage(iconImage, for: .highlighted)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setCornerButton() -> Void {
        self.layer.masksToBounds = false
        self.layer.cornerRadius = 5
    }
}
