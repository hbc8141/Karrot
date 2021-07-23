//
//  ItemDetailController.swift
//  Karrot
//
//  Created by User on 2021/07/18.
//

import UIKit
import RxSwift
import RxCocoa

class ItemDetailController: BaseController {

    // MARK: - Properties
    let itemImageListView:ItemImageListView = ItemImageListView()

    private let itemTitleLabel:BaseLabel = BaseLabel()
    
    private let tableview:BaseTableView = BaseTableView()
    
    private let barButtonStackView:UIStackView = {
        let iconSize:CGSize = CGSize(width: 30, height: 30)
        
        let shareButton = UIButton(type: .custom)
        shareButton.setImage(UIImage.fontAwesomeIcon(name: .shareAlt, style: .solid, textColor: .white, size: iconSize), for: .normal)
        
        let ellipsisVButton = UIButton(type: .custom)
        ellipsisVButton.setImage(UIImage.fontAwesomeIcon(name: .ellipsisV, style: .solid, textColor: .white, size: iconSize), for: .normal)
        
        let stackView:UIStackView = UIStackView(arrangedSubviews: [shareButton, ellipsisVButton])
        stackView.spacing = 8
        
        return stackView
    }()
    
    var item:Item?

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubviews(views: [
            self.itemImageListView, self.itemTitleLabel, self.itemImageListView
        ])
        
        self.setRightButton(UIBarButtonItem(customView: self.barButtonStackView))
        
        self.setupLayouts()
        self.setImageCollectionView()
//        self.bindUI()
    }
    
    // MARK: - Function
    override func setupLayouts() {
        let height:CGFloat = UIScreen.main.bounds.size.height

        NSLayoutConstraint.activate([
            self.itemImageListView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.itemImageListView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.itemImageListView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.itemImageListView.heightAnchor.constraint(equalToConstant: height / 2),
            
            self.itemTitleLabel.topAnchor.constraint(equalTo: self.itemImageListView.bottomAnchor),
            self.itemTitleLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.itemTitleLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
        ])
    }
    
    override func bindUI() {
        
    }
    
    fileprivate func setImageCollectionView() {
        self.itemImageListView.itemImageCollectionView.register(ItemImageCell.self, forCellWithReuseIdentifier: "cell")
        self.itemImageListView.itemImageCollectionView.rx.setDelegate(self).disposed(by: self.disposeBag)
        
        let cellType = Observable.of(item?.imageUrl).flatMap { (imageUrl:[String]?) -> Observable<[String]> in
            guard let imageUrl:[String] = imageUrl else { return .empty() }

            return .just(imageUrl)
        }
        
        let pageControlCount = cellType.map { $0.count }
            
        pageControlCount.bind(to: self.itemImageListView.pageControl.rx.numberOfPages)
            .disposed(by: self.disposeBag)
        
        pageControlCount.map { $0 > 0 ? false : true }.bind(to: self.itemImageListView.pageControl.rx.isHidden)
            .disposed(by: self.disposeBag)
        
        cellType.bind(to: self.itemImageListView.itemImageCollectionView.rx.items(cellIdentifier: "cell", cellType: ItemImageCell.self)) { (row:Int, imageUrl: String, cell:ItemImageCell) in
            cell.imageUrl = imageUrl
        }.disposed(by: self.disposeBag)
        
        self.itemImageListView.itemImageCollectionView.reloadData()
    }
}
