//
//  SplashViewController.swift
//  Karrot
//
//  Created by User on 2021/07/16.
//

import UIKit

class SplashController: UIViewController {

    private let imageView:BaseImageView = BaseImageView(image: nil, contentMode: .scaleAspectFit)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let mainController:StartController = StartController()
        let navController:BaseNavigationController = BaseNavigationController(rootViewController: mainController)

        let window = UIApplication.shared.windows.first ?? UIWindow()
        window.rootViewController = navController
        window.makeKeyAndVisible()
        // Do any additional setup after loading the view.
    }
}
