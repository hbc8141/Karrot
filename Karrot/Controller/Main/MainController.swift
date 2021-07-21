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
    private let itemTableView:BaseTableView = {
        let tableView:BaseTableView = BaseTableView()
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(valueChangedRefreshControl(_:)), for: .valueChanged)
        tableView.refreshControl = refreshControl
        
        return tableView
    }()
    
    private let floatingButton:BaseButton = {
        let button:BaseButton = BaseButton()
        button.layer.masksToBounds = false
        button.layer.cornerRadius = 25
        button.backgroundColor = .orange
        button.setTitle("+", for: .normal)

        return button
    }()

    let items:[Item] = [
        Item(title: "5버튼 슬림핏 코튼 반팔 카라티셔츠", content: "개봉통", imageUrl: "https://st.depositphotos.com/1428083/2946/i/950/depositphotos_29460297-stock-photo-bird-cage.jpg", price: 45000, heart: nil),
        Item(title: "5버튼 슬림핏 코튼 반팔 카라티셔츠", content: "개봉통", imageUrl: "http://www.foodnmed.com/news/photo/201903/18296_3834_4319.jpg", price: 45000, heart: nil),
        Item(title: "5버튼 슬림핏 코튼 반팔 카라티셔츠", content: "개봉통", imageUrl: "http://www.foodnmed.com/news/photo/201903/18296_3834_4319.jpg", price: 45000, heart: nil)
    ]
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubviews(views: [
            self.itemTableView, self.floatingButton
        ])

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
    fileprivate func setTableView() {
        self.itemTableView.register(ItemCell.self, forCellReuseIdentifier: "cell")
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
