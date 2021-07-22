//
//  FindLocationController.swift
//  Karrot
//
//  Created by User on 2021/07/21.
//

import UIKit
import RxSwift

class FindLocationController: BaseController {

    // MARK: - Properties
    private let findMyLocationButton:BaseButton = {
        let findMyLocationButton:BaseButton = BaseButton(title: "내 위치 찾기")
        
        return findMyLocationButton
    }()
    
    private lazy var addressTableView:BaseTableView = {
        let tableView:BaseTableView = BaseTableView()
        tableView.register(FindLocationCell.self, forCellReuseIdentifier: "cell")
        tableView.isHidden = true

        return tableView
    }()
    
    private let notFoundLocationView:NotFoundLocationView = NotFoundLocationView()
    
    private let searchTextField:BaseTextField = {
        let textField:BaseTextField = BaseTextField(text: nil, placeholder: "동명(읍, 면)으로 검색 (ex. 서초동)")
        textField.leftView = UIImageView(image: UIImage.fontAwesomeIcon(name: .search, style: .solid, textColor: .gray, size: CGSize(width: 25, height: 25)))
        textField.leftViewMode = .always
        textField.autocorrectionType = .no
        textField.returnKeyType = .search
        textField.clearButtonMode = .whileEditing
        
        return textField
    }()
    
    private let findStreet:[FindStreet] = [
        FindStreet(mainStreet: "부산시 남구 용호동", subStreet: nil),
        FindStreet(mainStreet: "서울시 구로구 오류동", subStreet: nil),
        FindStreet(mainStreet: "강원도 고성군 거진읍", subStreet: "거진리, 냉천리, 대대리"),
    ]
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.titleView = self.searchTextField
        
        self.view.addSubviews(views: [
            self.findMyLocationButton,
            self.addressTableView,
            self.notFoundLocationView
        ])

        self.showNavBar()
        self.setupLayouts()
        self.bindUI()
    }
    
    // MARK: - Function
    override func setupLayouts() {
        NSLayoutConstraint.activate([
            self.findMyLocationButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 15),
            self.findMyLocationButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 25),
            self.findMyLocationButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -25),
            self.findMyLocationButton.heightAnchor.constraint(equalToConstant: 35),
            
            self.addressTableView.topAnchor.constraint(equalTo: self.findMyLocationButton.bottomAnchor, constant: 10),
            self.addressTableView.leadingAnchor.constraint(equalTo: self.findMyLocationButton.leadingAnchor),
            self.addressTableView.trailingAnchor.constraint(equalTo: self.findMyLocationButton.trailingAnchor),
            self.addressTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            
            self.notFoundLocationView.topAnchor.constraint(equalTo: self.findMyLocationButton.bottomAnchor, constant: 75),
            self.notFoundLocationView.leadingAnchor.constraint(equalTo: self.findMyLocationButton.leadingAnchor),
            self.notFoundLocationView.trailingAnchor.constraint(equalTo: self.findMyLocationButton.trailingAnchor),
            self.notFoundLocationView.heightAnchor.constraint(equalToConstant: 250)
        ])
    }
    
    override func bindUI() {
        let searchMyTownButtonOb = self.notFoundLocationView.searchMyTownButton
            .rx.tap
            .share()
        
        searchMyTownButtonOb
            .subscribe(onNext: { _ in
                self.searchTextField.becomeFirstResponder()
            }).disposed(by: self.disposeBag)
        
        searchMyTownButtonOb
            .map { false }
            .bind(to: self.addressTableView.rx.isHidden)
            .disposed(by: self.disposeBag)
        
        searchMyTownButtonOb
            .map { true }
            .bind(to: self.notFoundLocationView.rx.isHidden)
            .disposed(by: self.disposeBag)
        
        self.findMyLocationButton.rx.tap
            .asDriver()
            .drive(onNext: {
                self.pushViewController(MainController())
            }).disposed(by: self.disposeBag)
        
        let searchTextOb = self.searchTextField.rx.text.orEmpty
            .withLatestFrom(Observable.of(self.findStreet)) { ($0, $1) }
            .flatMap { (text, streets) -> Observable<[FindStreet]> in
                let filter:[FindStreet] = streets.filter { $0.mainStreet.contains(text) }
                
                return .just(filter)
            }.share()
            
        searchTextOb.bind(to: self.addressTableView.rx.items(cellIdentifier: "cell", cellType: FindLocationCell.self)) { (row:Int, street:FindStreet, cell:FindLocationCell) in
                cell.findStreet = street
            }.disposed(by: self.disposeBag)
        
        let isFindStreetOb = searchTextOb.map { $0.count > 0 ? false : true }.share()
            
        isFindStreetOb.bind(to: self.addressTableView.rx.isHidden)
            .disposed(by: self.disposeBag)
        
        isFindStreetOb.map { !$0 } .bind(to: self.notFoundLocationView.rx.isHidden)
            .disposed(by: self.disposeBag)
    }
}
