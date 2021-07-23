//
//  ItemImgeCollectionView.swift
//  Karrot
//
//  Created by User on 2021/07/23.
//

import Foundation
import UIKit

class ItemImageListView: BaseView {
    
    // MARK: - Properties
    let itemImageCollectionView:BaseCollectionView = {
        let collectionView:BaseCollectionView = BaseCollectionView(scrollDirection: .horizontal)
        collectionView.isPagingEnabled = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        
        return collectionView
    }()
    
    let pageControl:UIPageControl = {
        let pageControl:UIPageControl = UIPageControl()
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        
        return pageControl
    }()
    
    // MARK: - Life Cycle
    init() {
        super.init()
        
        self.addSubviews(views: [
            self.itemImageCollectionView, self.pageControl
        ])
        
        self.setupLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Function
    override func setupLayouts() {
        NSLayoutConstraint.activate([
            self.itemImageCollectionView.topAnchor.constraint(equalTo: self.topAnchor),
            self.itemImageCollectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.itemImageCollectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.itemImageCollectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            self.pageControl.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            self.pageControl.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            self.pageControl.heightAnchor.constraint(equalToConstant: 10),
            self.pageControl.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
        ])
    }
}
