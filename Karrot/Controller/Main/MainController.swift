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
    private let itemTableView:BaseTableView = BaseTableView()
    
    private let floatingButton:BaseButton = {
        let button:BaseButton = BaseButton()
        button.layer.masksToBounds = false
        button.layer.cornerRadius = 25
        button.backgroundColor = .orange
        button.setTitle("+", for: .normal)

        return button
    }()

    let items:[Item] = [
        Item(title: "5버튼 슬림핏 코튼 반팔 카라티셔츠", content: "개봉통", imageUrl: "https://lh3.googleusercontent.com/proxy/TcqXq_WWuapLILeUi3cL2aZYO_ZkJhXxkn_mFvpiZbWFNli1dvLXrEsDqWHXHVjs2_7ynwEYRDtEtDtYo1PhRT12B_wgqF28538WP_Q11hqB_XPt5Q", price: 45000, heart: nil)
    ]

    private let disposeBag:DisposeBag = DisposeBag()
    
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
//        self.viewModel.items.
    }
    
    // MARK: - Function
    fileprivate func setTableView() {
        self.itemTableView.register(ItemCell.self, forCellReuseIdentifier: "cell")
        self.itemTableView.rx.setDelegate(self).disposed(by: self.disposeBag)

        let cellType = Observable.of(items)
        
        cellType.bind(to: itemTableView.rx.items(cellIdentifier: "cell", cellType: ItemCell.self)) { (row:Int, item:Item, cell:ItemCell) in
            cell.itemNameLabel.text = item.title
            cell.itemContentLabel.text = item.content
            cell.priceLabel.text = "45000"
            
            if let url:URL = URL(string: item.imageUrl) {
                do {
                    let imageData:Data = try Data(contentsOf: url)
                    cell.imageView?.image = UIImage(data: imageData)
                } catch { }
            }
        }.disposed(by: self.disposeBag)
        
        self.itemTableView.reloadData()
    }
}
