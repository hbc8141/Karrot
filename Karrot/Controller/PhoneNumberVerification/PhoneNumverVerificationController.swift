//
//  PhoneNumverVerificationController.swift
//  Karrot
//
//  Created by User on 2021/08/02.
//

import UIKit

class PhoneNumverVerificationController: BaseController {

    // MARK: - Properties
    private let lockImageView:BaseImageView = BaseImageView(image: .location, contentMode: .scaleToFill)
    
    private let contentLabel:BaseLabel = {
        let label:BaseLabel = BaseLabel()
        let boldFont = UIFont.boldSystemFont(ofSize: 22)
        let attributeString:NSMutableAttributedString = NSMutableAttributedString(string: "당근마켓은 휴대폰 번호로 가입해요.\n번호로 안전하게 보관 되며\n어디에도 공개되지 않아요.")
        attributeString.addAttribute(.font, value: boldFont, range: NSRange(location: 24, length: 7))
        label.attributedText = attributeString
        
        return label
    }()
    
    private lazy var phoneNumberTextField:BaseTextField = {
        let textField:BaseTextField = BaseTextField(placeholder: "휴대폰 번호(- 없이 숫자만 입력)")
        textField.layer.masksToBounds = false
        textField.layer.cornerRadius = 5
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.keyboardType = .numberPad
        textField.delegate = self
        
        return textField
    }()
    
    private let verificationSmsButton:BaseButton = BaseButton(title: "인증문자 받기", backgroundColor: .gray)
    
    private let verficationView:VerficationView = VerficationView()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubviews(views: [
            self.lockImageView, self.contentLabel,
            self.phoneNumberTextField, self.verificationSmsButton,
            self.verficationView
        ])

        self.showNavBar(title: "전화번호 인증")

        self.setupLayouts()
        self.bindUI()
    }
    
    // MARK: - Function
    override func setupLayouts() {
        NSLayoutConstraint.activate([
            self.lockImageView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 30),
            self.lockImageView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 25),
            self.lockImageView.widthAnchor.constraint(equalToConstant: 100),
            self.lockImageView.heightAnchor.constraint(equalToConstant: 75),
            
            self.contentLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 30),
            self.contentLabel.leadingAnchor.constraint(equalTo: self.lockImageView.trailingAnchor, constant: 15),
            self.contentLabel.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -25),
            self.contentLabel.bottomAnchor.constraint(equalTo: self.lockImageView.bottomAnchor),
            
            self.phoneNumberTextField.topAnchor.constraint(equalTo: self.contentLabel.safeAreaLayoutGuide.bottomAnchor, constant: 15),
            self.phoneNumberTextField.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 25),
            self.phoneNumberTextField.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -25),
            self.phoneNumberTextField.heightAnchor.constraint(equalToConstant: 50),
            
            self.verificationSmsButton.topAnchor.constraint(equalTo: self.phoneNumberTextField.safeAreaLayoutGuide.bottomAnchor, constant: 15),
            self.verificationSmsButton.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 25),
            self.verificationSmsButton.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -25),
            self.verificationSmsButton.heightAnchor.constraint(equalToConstant: 50),
            
            self.verficationView.topAnchor.constraint(equalTo: self.verificationSmsButton.safeAreaLayoutGuide.bottomAnchor, constant: 15),
            self.verficationView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 25),
            self.verficationView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -25),
            self.verficationView.heightAnchor.constraint(equalToConstant: 150),
        ])
    }
    
    override func bindUI() {
        let phoneNumberOb = self.phoneNumberTextField.rx.text.orEmpty
            .map { $0.count == 11 ? true : false }
            .share()
            
        phoneNumberOb.map { $0 ? UIColor.black : UIColor.gray }.bind(to: self.verificationSmsButton.rx.backgroundColor)
            .disposed(by: self.disposeBag)
        
        phoneNumberOb.bind(to: self.verificationSmsButton.rx.isUserInteractionEnabled)
            .disposed(by: self.disposeBag)
        
        self.verificationSmsButton.rx.tap
            .map { false }
            .bind(to: self.verficationView.rx.isHidden)
            .disposed(by: self.disposeBag)
        
        self.verificationSmsButton.rx.tap
            .map { "인증문자 다시 받기" }
            .bind(to: self.verificationSmsButton.rx.title())
            .disposed(by: self.disposeBag)
        
        self.verficationView.verificationButton.rx.tap
            .asDriver()
            .drive(onNext: { _ in
                self.view.window?.rootViewController = BaseNavigationController(rootViewController: MainController())
                self.view.window?.makeKeyAndVisible()
            }).disposed(by: self.disposeBag)
    }
}

extension PhoneNumverVerificationController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return false }

        return "\(text)\(string)".count > 11 ? false : true
    }
}
