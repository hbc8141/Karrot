//
//  MainController.swift
//  Karrot
//
//  Created by User on 2021/07/16.
//

import UIKit
import RxSwift
import RxCocoa

class MainController: BaseController {

    // MARK: - Properties
    private lazy var itemTableView:BaseTableView = {
        let tableView:BaseTableView = BaseTableView()
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(valueChangedRefreshControl(_:)), for: .valueChanged)
        refreshControl.tintColor = .orange
        tableView.refreshControl = refreshControl
        tableView.register(ItemCell.self, forCellReuseIdentifier: "cell")
        
        return tableView
    }()
    
    private let floatingButton:BaseButton = {
        let button:BaseButton = BaseButton()
        button.layer.masksToBounds = false
        button.layer.cornerRadius = 25
        button.setImage(UIImage.fontAwesomeIcon(name: .plus, style: .solid, textColor: .white, size: CGSize(width: 25, height: 25)), for: .normal)

        return button
    }()

    let items:[Item] = [
        Item(title: "5버튼 슬림핏 코튼 반팔 카라티셔츠", content: "개봉동", imageUrl: [
            "https://st.depositphotos.com/1428083/2946/i/950/depositphotos_29460297-stock-photo-bird-cage.jpg",
            "https://images.unsplash.com/photo-1480074568708-e7b720bb3f09?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1953&q=80"
        ], price: 45000, msgAndHeart: MsgAndHeart(msgCnt: 1, heartCnt: nil)),
        Item(title: "5버튼 슬림핏 코튼 반팔 카라티셔츠", content: "개봉동", imageUrl: [
            "http://www.foodnmed.com/news/photo/201903/18296_3834_4319.jpg"
        ], price: 45000, msgAndHeart: MsgAndHeart(msgCnt: 1, heartCnt: 4)),
        Item(title: "5버튼 슬림핏 코튼 반팔 카라티셔츠", content: "개봉동", imageUrl: [
            "http://www.foodnmed.com/news/photo/201903/18296_3834_4319.jpg"
        ], price: 45000, msgAndHeart: MsgAndHeart(msgCnt: 1, heartCnt: nil)),
        Item(title: "5버튼 슬림핏 코튼 반팔 카라티셔츠", content: "개봉동", imageUrl: [
            "http://www.foodnmed.com/news/photo/201903/18296_3834_4319.jpg"
        ], price: 45000, msgAndHeart: MsgAndHeart(msgCnt: nil, heartCnt: 4))
    ]

    private let barButtonStackView:UIStackView = {
        let iconSize:CGSize = CGSize(width: 30, height: 30)
        
        let searchButton = UIButton(type: .custom)
        searchButton.setImage(UIImage.fontAwesomeIcon(name: .search, style: .solid, textColor: .black, size: iconSize), for: .normal)
        
        let menuButton = UIButton(type: .custom)
        menuButton.setImage(UIImage.fontAwesomeIcon(name: .alignJustify, style: .solid, textColor: .black, size: iconSize), for: .normal)
        
        let alarmButton = UIButton(type: .custom)
        alarmButton.setImage(UIImage.fontAwesomeIcon(name: .bell, style: .regular, textColor: .black, size: iconSize), for: .normal)
        
        let stackView:UIStackView = UIStackView(arrangedSubviews: [searchButton, menuButton, alarmButton])
        stackView.spacing = 8
        
        return stackView
    }()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubviews(views: [
            self.itemTableView, self.floatingButton
        ])
        
        self.setRightButton(UIBarButtonItem(customView: self.barButtonStackView))

        self.setupLayouts()
        self.bindUI()
        self.setTableView()
    }
    
    // MARK: - Initialization
    override func setupLayouts() {
        NSLayoutConstraint.activate([
            self.itemTableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.itemTableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            self.itemTableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            self.itemTableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            
            self.floatingButton.widthAnchor.constraint(equalToConstant: 50),
            self.floatingButton.heightAnchor.constraint(equalToConstant: 50),
            self.floatingButton.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            self.floatingButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -15),
        ])
    }
    
    override func bindUI() {
    }
    
    // MARK: - Function
    @objc private func touchUpSearchButton(_ sender: UIBarButtonItem) -> Void {
        
    }
    
    @objc private func touchUpMenuButton(_ sender: UIBarButtonItem) -> Void {
        
    }
    
    @objc private func touchUpAlarmButton(_ sender: UIBarButtonItem) -> Void {
        
    }
    
    fileprivate func setTableView() {
        self.itemTableView.rx.setDelegate(self).disposed(by: self.disposeBag)

        let cellType = Observable.of(items)
        
        cellType.bind(to: itemTableView.rx.items(cellIdentifier: "cell", cellType: ItemCell.self)) { (row:Int, item:Item, cell:ItemCell) in
            cell.item = item
        }.disposed(by: self.disposeBag)
        
        self.itemTableView.reloadData()
    }
    
    // MARK: - Objc Function
    @objc private func valueChangedRefreshControl(_ sender: UIRefreshControl) -> Void {
        sender.endRefreshing()
        self.itemTableView.reloadData()
    }
}
