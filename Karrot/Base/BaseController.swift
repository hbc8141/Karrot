//
//  BaseController.swift
//  Karrot
//
//  Created by User on 2021/07/16.
//

import UIKit
import RxSwift

class BaseController: UIViewController {
    
    // MARK: - Properties
    private let networkNotConnectedView:NetworkNotConnectedView = NetworkNotConnectedView()
    
    var disposeBag:DisposeBag = DisposeBag()

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        if NetworkMonitor.shared.isConnected {
            print("You're connected internet")
        } else {
            print("You're not connected internet")
        }
    }
    
    // MARK: - Function
    private func baseUI() -> Void {
        self.view.addSubview(self.networkNotConnectedView)

        NSLayoutConstraint.activate([
            self.networkNotConnectedView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.networkNotConnectedView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.networkNotConnectedView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.networkNotConnectedView.heightAnchor.constraint(equalToConstant: 250)
        ])
    }
    
    func bindUI() -> Void {}
    
    func setupLayouts() -> Void {}
    
    // 스낵바 제목 설정
    func setSnackbarTitle(title: String?) -> Void {
        self.networkNotConnectedView.setTitle(text: title)
    }
    
    // 네비게이션 우측 아이콘 설정
    func setRightButton(_ barButtonItem:UIBarButtonItem) -> Void {
        self.navigationItem.rightBarButtonItem = barButtonItem
    }
    
    // 네비게이션바 숨김
    func hideNavBar() -> Void {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    // 네비게이션바 보이기
    func showNavBar() -> Void {
        self.navigationController?.navigationBar.isHidden = false
    }
    
    // 다음화면으로 이동
    func pushViewController(_ controller: BaseController) -> Void {
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    // 이전화면으로 이동
    func popViewController() -> Void {
        self.navigationController?.popViewController(animated: true)
    }
}
