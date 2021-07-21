//
//  StartController.swift
//  Karrot
//
//  Created by User on 2021/07/21.
//

import UIKit
import RxSwift
import RxCocoa

class StartController: BaseController {
    
    // MARK: - Properties
    private let imageView:BaseImageView = BaseImageView()

    private let titleLabel:BaseLabel = {
        let label:BaseLabel = BaseLabel(title: "우리 동네 중고 직거래 당근마켓", textAlignment: .center)
        label.font = UIFont.boldSystemFont(ofSize: 20)
        
        return label
    }()
    
    private let contentLabel:BaseLabel = BaseLabel(title: "당근마켓은 동네 직거래 마켓이에요.\n내 동네를 설정하고 시작해보세요!", textAlignment: .center)
    
    private let nextButton:BaseButton = BaseButton(title: "내 동네 설정하고 시작하기", backgroundColor: .orange)
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubviews(views: [
            self.imageView, self.titleLabel, self.contentLabel, self.nextButton
        ])
        
        self.setupLayouts()
        self.bindUI()
    }

    // MARK: - Function
    override func setupLayouts() {
        NSLayoutConstraint.activate([
            self.imageView.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor),
            self.imageView.centerYAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerYAnchor),
            self.imageView.widthAnchor.constraint(equalToConstant: 250),
            self.imageView.heightAnchor.constraint(equalToConstant: 250),
            
            self.titleLabel.topAnchor.constraint(equalTo: self.imageView.safeAreaLayoutGuide.bottomAnchor, constant: 25),
            self.titleLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 25),
            self.titleLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -25),
            self.titleLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 0),
            
            self.contentLabel.topAnchor.constraint(equalTo: self.titleLabel.safeAreaLayoutGuide.bottomAnchor, constant: 25),
            self.contentLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 25),
            self.contentLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -25),
            self.contentLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 0),
            
            self.nextButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -25),
            self.nextButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 25),
            self.nextButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -25),
            self.nextButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    override func bindUI() {
        self.nextButton.rx.tap
            .asDriver()
            .drive(onNext: { _ in
                self.pushViewController(FindLocationController())
            }).disposed(by: self.disposeBag)
    }
}
