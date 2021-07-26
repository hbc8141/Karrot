//
//  TradeView.swift
//  Karrot
//
//  Created by User on 2021/07/26.
//

import UIKit

class TradeView: BaseView {
    
    // MARK: - Properties
    private let heartButton:BaseButton = BaseButton(fontIcon: .heart, style: .regular)
    
    private let priceLabel:BaseLabel = BaseLabel(title: "45000원")
    
    private let priceSuggestionLabel:BaseLabel = BaseLabel(title: "가격제안불가")
    
    private let goToChatButton:BaseButton = BaseButton(title: "채팅으로 거래하기")
    
    private let innerView:BaseView = BaseView()
    
    private let innerViewWithoutHeartView:BaseView = BaseView()

    // MARK: - Life Cycle
    init() {
        super.init()
        
        self.layer.masksToBounds = true
        self.layer.borderColor = UIColor.gray.cgColor
        self.layer.borderWidth = 0.3
        
        self.addSubview(self.innerView)
        
        self.innerView.addSubviews(views: [
            self.heartButton,
            self.innerViewWithoutHeartView
        ])
        
        self.innerViewWithoutHeartView.addSubviews(views: [
            self.priceLabel,
            self.priceSuggestionLabel,
            self.goToChatButton
        ])
        
        self.setupLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Function
    override func setupLayouts() {
        NSLayoutConstraint.activate([
            self.innerView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.innerView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            self.innerView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15),
            self.innerView.heightAnchor.constraint(equalToConstant: 50),
            
            self.heartButton.topAnchor.constraint(equalTo: self.innerView.topAnchor),
            self.heartButton.leadingAnchor.constraint(equalTo: self.innerView.leadingAnchor),
            self.heartButton.widthAnchor.constraint(equalToConstant: 50),
            self.heartButton.bottomAnchor.constraint(equalTo: self.innerView.bottomAnchor),
            
            self.innerViewWithoutHeartView.topAnchor.constraint(equalTo: self.innerView.topAnchor),
            self.innerViewWithoutHeartView.leadingAnchor.constraint(equalTo: self.heartButton.trailingAnchor),
            self.innerViewWithoutHeartView.trailingAnchor.constraint(equalTo: self.innerView.trailingAnchor),
            self.innerViewWithoutHeartView.bottomAnchor.constraint(equalTo: self.innerView.bottomAnchor),
            
            self.priceLabel.topAnchor.constraint(equalTo: self.innerViewWithoutHeartView.topAnchor),
            self.priceLabel.leadingAnchor.constraint(equalTo: self.innerViewWithoutHeartView.leadingAnchor),
            self.priceLabel.trailingAnchor.constraint(equalTo: self.goToChatButton.leadingAnchor),
            self.priceLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 0),
            
            self.priceSuggestionLabel.topAnchor.constraint(equalTo: self.priceLabel.bottomAnchor),
            self.priceSuggestionLabel.leadingAnchor.constraint(equalTo: self.innerViewWithoutHeartView.leadingAnchor),
            self.priceSuggestionLabel.trailingAnchor.constraint(equalTo: self.goToChatButton.leadingAnchor),
            self.priceSuggestionLabel.bottomAnchor.constraint(equalTo: self.innerViewWithoutHeartView.bottomAnchor),

            self.goToChatButton.topAnchor.constraint(equalTo: self.innerViewWithoutHeartView.topAnchor),
            self.goToChatButton.trailingAnchor.constraint(equalTo: self.innerViewWithoutHeartView.trailingAnchor),
            self.goToChatButton.widthAnchor.constraint(equalToConstant: 175),
            self.goToChatButton.bottomAnchor.constraint(equalTo: self.innerViewWithoutHeartView.bottomAnchor)
        ])
    }
}
