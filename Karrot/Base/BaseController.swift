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
    func bindUI() -> Void {}
    
    func setupLayouts() -> Void {}
    
    func pushViewController(_ controller: BaseController) -> Void {
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func popViewController() -> Void {
        self.navigationController?.popViewController(animated: true)
    }
}
