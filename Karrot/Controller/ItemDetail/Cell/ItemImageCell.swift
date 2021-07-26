//
//  ItemImageCell.swift
//  Karrot
//
//  Created by User on 2021/07/26.
//

import UIKit
import RxSwift
import RxCocoa

class ItemImageCell: BaseTableViewCell {

    // MARK: - Properties
    var item:Item?
    
    let itemImageCollectionView:BaseCollectionView = {
        let collectionView:BaseCollectionView = BaseCollectionView(scrollDirection: .horizontal)
        collectionView.isPagingEnabled = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(ItemImageCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        
        return collectionView
    }()
    
    let pageControl:BasePageControl = BasePageControl()
    
    // MARK: - Life Cycles
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubviews(views: [
            self.itemImageCollectionView, self.pageControl
        ])
        
        self.setupLayouts()
        self.bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Function
    override func setupLayouts() {
        NSLayoutConstraint.activate([
            self.itemImageCollectionView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.itemImageCollectionView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.itemImageCollectionView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            self.itemImageCollectionView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            
            self.pageControl.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10),
            self.pageControl.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -10),
            self.pageControl.heightAnchor.constraint(equalToConstant: 10),
            self.pageControl.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -10),
        ])
    }
    
    override func bind() {
        self.itemImageCollectionView.rx.setDelegate(self).disposed(by: self.disposeBag)

//        Observable.of(item).flatMap { (item:Item?) -> Observable<[String]> in
//            guard let item:Item = item else { return .empty() }
//
//            return .just(item.imageUrl)
//        }
//        .bind(to: self.itemImageCollectionView.rx.items(cellIdentifier: "cell", cellType: ItemImageCollectionViewCell.self)) { (row:Int, imageUrl: String, cell:ItemImageCollectionViewCell) in
//                cell.imageUrl = imageUrl
//        }.disposed(by: self.disposeBag)
    }
}
