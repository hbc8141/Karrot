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
    private let itemImageListView:ItemImageListView = ItemImageListView()
    
    private let pageControl:UIPageControl = UIPageControl()

    private let itemTitleLabel:BaseLabel = BaseLabel()
    
    var item:Item?

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubviews(views: [
            self.itemImageListView, self.itemTitleLabel, self.itemImageListView
        ])
        
        self.setupLayouts()
        self.setImageCollectionView()
//        self.bindUI()
    }
    
    // MARK: - Function
    override func setupLayouts() {
        NSLayoutConstraint.activate([
            self.itemImageListView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.itemImageListView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.itemImageListView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.itemImageListView.heightAnchor.constraint(equalToConstant: 250),
            
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
