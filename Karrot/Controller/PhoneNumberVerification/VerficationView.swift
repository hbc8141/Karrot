//
//  VerficationView.swift
//  Karrot
//
//  Created by User on 2021/08/02.
//

import UIKit
import RxSwift

class VerficationView: BaseView {

    // MARK: - Properties
    private lazy var enterVerficationTextField:BaseTextField = {
        let textField:BaseTextField = BaseTextField(placeholder: "인증번호 입력")
        textField.layer.masksToBounds = false
        textField.layer.cornerRadius = 5
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.keyboardType = .numberPad
        
        return textField
    }()
    
    private let notShareLabel:BaseLabel = {
        let label:BaseLabel = BaseLabel()
        label.text = "어떤 경우에도 타인에게 공유하지 마세요!"
        label.textColor = .gray
        
        return label
    }()
    
    let verificationButton:BaseButton = BaseButton(title: "인증번호 확인", backgroundColor: .gray)
    
    private let disposeBag:DisposeBag = DisposeBag()
    
    // MARK: - Life Cycle
    init() {
        super.init()
        
        self.isHidden = true
        
        self.addSubviews(views: [
            self.enterVerficationTextField,
            self.notShareLabel,
            self.verificationButton
        ])
        
        self.setupLayouts()
        self.bindUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Function
    override func setupLayouts() {
        NSLayoutConstraint.activate([
            self.enterVerficationTextField.topAnchor.constraint(equalTo: self.topAnchor),
            self.enterVerficationTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.enterVerficationTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.enterVerficationTextField.heightAnchor.constraint(equalToConstant: 50),
            
            self.notShareLabel.topAnchor.constraint(equalTo: self.enterVerficationTextField.bottomAnchor, constant: 10),
            self.notShareLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.notShareLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.notShareLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 0),
            
            self.verificationButton.topAnchor.constraint(equalTo: self.notShareLabel.bottomAnchor, constant: 45),
            self.verificationButton.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.verificationButton.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.verificationButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    override func bindUI() {
        let enterVerficationOb = self.enterVerficationTextField.rx.text.orEmpty
            .map { $0.count > 0 ? true : false }
            .share()
            
        enterVerficationOb.map { $0 ? UIColor.orange : UIColor.gray }.bind(to: self.verificationButton.rx.backgroundColor)
            .disposed(by: self.disposeBag)
        
//        enterVerficationOb.bind(to: self.verificationButton.rx.isUserInteractionEnabled)
//            .disposed(by: self.disposeBag)
    }
}
