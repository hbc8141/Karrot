//
//  ItemDetailController.swift
//  Karrot
//
//  Created by User on 2021/07/18.
//

import UIKit
import RxSwift

class ItemDetailController: BaseController {

    // MARK: - Properties
    private let itemImageCollectionView:BaseCollectionView = BaseCollectionView(scrollDirection: .horizontal)
    
    private let pageControl:UIPageControl = UIPageControl()

    private let itemTitleLabel:BaseLabel = BaseLabel()
    
    var item:Item?

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubviews(views: [
             self.itemImageCollectionView, self.itemTitleLabel
        ])
        
        self.setupLayouts()
//        self.bindUI()
    }
    
    // MARK: - Function
    override func setupLayouts() {
        NSLayoutConstraint.activate([
            self.itemImageCollectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.itemImageCollectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.itemImageCollectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.itemImageCollectionView.heightAnchor.constraint(equalToConstant: 250),
            
            self.itemTitleLabel.topAnchor.constraint(equalTo: self.itemImageCollectionView.bottomAnchor),
            self.itemTitleLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.itemTitleLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
    }
    
    override func bindUI() {

    }
}
