//
//  BaseController.swift
//  Karrot
//
//  Created by User on 2021/07/16.
//

import UIKit

class BaseController: UIViewController {
    
    private let networkNotConnectedView:NetworkNotConnectedView = NetworkNotConnectedView()

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
    func bindUI() -> Void {
        
    }
    
    func setupLayouts() -> Void {}
}
