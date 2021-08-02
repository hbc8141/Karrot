//
//  NotFoundLocationView.swift
//  Karrot
//
//  Created by User on 2021/07/22.
//

import UIKit

class NotFoundLocationView: BaseView {

    // MARK: - Properties
    private let houseImageView:BaseImageView = BaseImageView(image: .house)
    
    private let titleLabel:BaseLabel = BaseLabel(title: "현재 위치로 동네를 받아오지 못했어요.\n내 동네 이름으로 검색해보세요!", textColor: .gray, textAlignment: .center)
    
    private let _searchMyTownButton:BaseButton = {
        let button:BaseButton = BaseButton(title: "내 동네 이름 검색하기", backgroundColor: .white)
        button.setTitleColor(.orange, for: .normal)
        button.setTitleColor(.orange, for: .highlighted)
        
        return button
    }()
    
    var searchMyTownButton:BaseButton {
        get {
            return _searchMyTownButton
        }
    }
    
    // MARK: - Life Cycle
    init() {
        super.init()
        
        self.addSubviews(views: [
            self.houseImageView, self.titleLabel, self._searchMyTownButton
        ])
        
        self.setupLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Function
    override func setupLayouts() {
        NSLayoutConstraint.activate([
            self.houseImageView.topAnchor.constraint(equalTo: self.topAnchor),
            self.houseImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.houseImageView.widthAnchor.constraint(equalToConstant: 75),
            self.houseImageView.heightAnchor.constraint(equalToConstant: 75),
            
            self.titleLabel.topAnchor.constraint(equalTo: self.houseImageView.bottomAnchor, constant: 10),
            self.titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.titleLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 0),
            
            self._searchMyTownButton.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 25),
            self._searchMyTownButton.leadingAnchor.constraint(equalTo: self.titleLabel.leadingAnchor),
            self._searchMyTownButton.trailingAnchor.constraint(equalTo: self.titleLabel.trailingAnchor),
            self._searchMyTownButton.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
}
