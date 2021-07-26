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

    private let itemTitleLabel:BaseLabel = BaseLabel()
    
    private let itemInfoTableview:BaseTableView = {
        let tableView:BaseTableView = BaseTableView()
        tableView.register(ItemImageCell.self, forCellReuseIdentifier: "imageCell")
        tableView.register(UserCell.self, forCellReuseIdentifier: "userCell")
        tableView.contentInsetAdjustmentBehavior = .never
        
        return tableView
    }()
    
    private let tradeView:TradeView = TradeView()
    
    private lazy var barButtonStackView:UIStackView = {
        let iconSize:CGSize = CGSize(width: 30, height: 30)
        
        let shareButton = UIButton(type: .custom)
        shareButton.setImage(UIImage.fontAwesomeIcon(name: .shareAlt, style: .solid, textColor: .white, size: iconSize), for: .normal)
        shareButton.addTarget(self, action: #selector(touchUpShareButton(_:)), for: .touchUpInside)
        
        let ellipsisVButton = UIButton(type: .custom)
        ellipsisVButton.setImage(UIImage.fontAwesomeIcon(name: .ellipsisV, style: .solid, textColor: .white, size: iconSize), for: .normal)
        ellipsisVButton.addTarget(self, action: #selector(touchUpEllipsisVButton(_:)), for: .touchUpInside)
        
        let stackView:UIStackView = UIStackView(arrangedSubviews: [shareButton, ellipsisVButton])
        stackView.spacing = 8
        
        return stackView
    }()
    
    var item:Item?
    
    private let seller:Seller = Seller()

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubviews(views: [
            self.itemInfoTableview,
//            self.itemTitleLabel,
            self.tradeView
        ])
        
        self.view.addSubview(self.tradeView)
        
        self.setRightButton(UIBarButtonItem(customView: self.barButtonStackView))
        
        self.setupLayouts()
        self.setTableView()
//        self.bindUI()
    }
    
    // MARK: - Function
    override func setupLayouts() {
        let height:CGFloat = UIScreen.main.bounds.size.height

        NSLayoutConstraint.activate([
            self.itemInfoTableview.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.itemInfoTableview.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.itemInfoTableview.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.itemInfoTableview.bottomAnchor.constraint(equalTo: self.tradeView.topAnchor),
            
            self.tradeView.heightAnchor.constraint(equalToConstant: 100),
            self.tradeView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.tradeView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.tradeView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            
//            self.itemTitleLabel.topAnchor.constraint(equalTo: self.itemImageListView.bottomAnchor),
//            self.itemTitleLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
//            self.itemTitleLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
        ])
    }
    
    override func bindUI() {
        
    }
    
    fileprivate func setTableView() {
        self.itemInfoTableview.rx.setDelegate(self).disposed(by: self.disposeBag)
        
        
//        self.itemImageListView.itemImageCollectionView.register(ItemImageCell.self, forCellWithReuseIdentifier: "cell")
//        self.itemImageListView.itemImageCollectionView.rx.setDelegate(self).disposed(by: self.disposeBag)
        
//        let cellType = Observable.of(item?.imageUrl).flatMap { (imageUrl:[String]?) -> Observable<[String]> in
//            guard let imageUrl:[String] = imageUrl else { return .empty() }
//
//            return .just(imageUrl)
//        }
        
        let cellTypeOb = Observable.of(item).flatMap({ (item:Item?) -> Observable<Item> in
            guard let item:Item = item else { return .empty() }

            return .just(item)
        }).share()
        
        let pageControlCount = cellTypeOb.map { $0.imageUrl.count }.share()
        
        Observable.of([item as Any, seller]).map { [$0] }.bind(to: self.itemInfoTableview.rx.items) { (tableView:UITableView, row:Int, items:[Any]) -> BaseTableViewCell in
            if row == 0 {
                guard let item:Item = items[row] as? Item else { return ItemImageCell() }
                guard let cell:ItemImageCell = tableView.dequeueReusableCell(withIdentifier: "imageCell") as? ItemImageCell else { return ItemImageCell() }
                cell.item = item
                
                Observable.of(item.imageUrl).flatMap { (imageUrl:[String]?) -> Observable<[String]> in
                    guard let imageUrl:[String] = imageUrl else { return .empty() }

                    return .just(imageUrl)
                }
                .bind(to: cell.itemImageCollectionView.rx.items(cellIdentifier: "cell", cellType: ItemImageCollectionViewCell.self)) { (row:Int, imageUrl: String, cell:ItemImageCollectionViewCell) in
                            cell.imageUrl = imageUrl
                }
                .disposed(by: cell.disposeBag)
                
                pageControlCount.bind(to: cell.pageControl.rx.numberOfPages)
                .disposed(by: cell.disposeBag)

                pageControlCount.map { $0 > 0 ? false : true }.bind(to: cell.pageControl.rx.isHidden)
                    .disposed(by: cell.disposeBag)
                
                return cell
            } else {
                guard let item:Seller = items[row] as? Seller else { return ItemImageCell() }
                guard let cell:ItemImageCell = tableView.dequeueReusableCell(withIdentifier: "imageCell") as? ItemImageCell else { return ItemImageCell() }
            }

            return BaseTableViewCell()
        }.disposed(by: self.disposeBag)
    }
    
    @objc private func touchUpEllipsisVButton(_ sender: UIButton) -> Void {
        let alertController:UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: "신고하기", style: .default, handler: nil))
        alertController.addAction(UIAlertAction(title: "이 사용자의 글 보지 않기", style: .default, handler: nil))
        alertController.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    @objc private func touchUpShareButton(_ sender: UIButton) -> Void {
        // Setting description
        let firstActivityItem = "Description you want.."

        // Setting url
        let secondActivityItem : NSURL = NSURL(string: "http://your-url.com/")!
        
        // If you want to use an image
        let image : UIImage = UIImage.image(name: .carrot) ?? UIImage()
        
        let controller = UIActivityViewController(activityItems: [
        firstActivityItem, secondActivityItem, image], applicationActivities: nil)
        controller.activityItemsConfiguration = [
            UIActivity.ActivityType.message
        ] as? UIActivityItemsConfiguration
        controller.excludedActivityTypes = [
            .print,
            .postToFacebook,
            .saveToCameraRoll,
            .assignToContact,
            .airDrop,
            .mail,
            .markupAsPDF,
            .message
        ]
        controller.isModalInPresentation = true
        self.present(controller, animated: true, completion: nil)
    }
}
