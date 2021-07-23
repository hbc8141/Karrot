//
//  NetworkNotConnectedView.swift
//  Karrot
//
//  Created by User on 2021/07/16.
//

import UIKit

class NetworkNotConnectedView: BaseView {

    // MARK: - Properties
    private let contentLabel:BaseLabel = BaseLabel(title: "네트워크가 연결되지 않았습니다.", textColor: .white)

    // MARK: - Life Cycle
    init() {
        super.init(color: .black)
        
        self.addSubview(self.contentLabel)
        
        self.setupLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Initialization
    override func setupLayouts() {
        NSLayoutConstraint.activate([
            self.contentLabel.topAnchor.constraint(equalTo: self.topAnchor),
            self.contentLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.contentLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.contentLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    // MARK: - Function
    func setTitle(text: String?) -> Void {
        self.contentLabel.text = text
    }
}
