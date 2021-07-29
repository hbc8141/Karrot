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
    
    private lazy var backgroundView:BaseView = {
        let view:BaseView = BaseView(color: .clear)
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(touchUpView(_:))))

        return view
    }()
    
    var item:Item?
    
    private let seller:Seller = Seller()

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubviews(views: [
            self.itemInfoTableview,
            self.tradeView,
            self.backgroundView
        ])
        
        self.view.addSubview(self.tradeView)
        self.backgroundView.isHidden = true
        
        self.setRightButton(UIBarButtonItem(customView: self.barButtonStackView))
        
        self.setupLayouts()
        self.setTableView()
    }
    
    // MARK: - Function
    override func setupLayouts() {
        NSLayoutConstraint.activate([
            self.itemInfoTableview.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.itemInfoTableview.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.itemInfoTableview.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.itemInfoTableview.bottomAnchor.constraint(equalTo: self.tradeView.topAnchor),
            
            self.tradeView.heightAnchor.constraint(equalToConstant: 100),
            self.tradeView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.tradeView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.tradeView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            
            self.backgroundView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.backgroundView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.backgroundView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.backgroundView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
    
    @objc private func touchUpView(_ sender:Any) {
        self.dismiss(animated: true) {
            self.backgroundView.isHidden = true
        }
    }
    
    // 테이블뷰 설정
    fileprivate func setTableView() {
        self.itemInfoTableview.rx.setDelegate(self).disposed(by: self.disposeBag)
        
        let cellTypeOb = Observable.of(item).flatMap({ (item:Item?) -> Observable<Item> in
            guard let item:Item = item else { return .empty() }

            return .just(item)
        }).share()
        
        let pageControlCount = cellTypeOb.map { $0.imageUrl.count }.share()
        
        Observable.of([item as Any, seller]).bind(to: self.itemInfoTableview.rx.items) { (tableView:UITableView, row:Int, item:Any) -> BaseTableViewCell in
            print(row)
            if row == 0 {
                guard let item:Item = item as? Item else { return ItemImageCell() }
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
                guard let seller:Seller = item as? Seller else { return UserCell() }
                guard let cell:UserCell = tableView.dequeueReusableCell(withIdentifier: "userCell") as? UserCell else { return UserCell() }
                cell.seller = seller
                
                return cell
            }
        }.disposed(by: self.disposeBag)
    }
    
    // 우측상단 메뉴 클릭
    @objc private func touchUpEllipsisVButton(_ sender: UIButton) -> Void {
        let alertController:UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: "신고하기", style: .default, handler: nil))
        alertController.addAction(UIAlertAction(title: "이 사용자의 글 보지 않기", style: .default, handler: nil))
        alertController.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    // 공유버튼 클릭
    @objc private func touchUpShareButton(_ sender: UIButton) -> Void {
        let firstActivityItem = "Description you want.."

        let secondActivityItem : NSURL = NSURL(string: "http://your-url.com/")!
        
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
        self.present(controller, animated: true) {
            self.backgroundView.isHidden = false
        }
    }
}
