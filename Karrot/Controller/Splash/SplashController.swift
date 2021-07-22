//
//  SplashViewController.swift
//  Karrot
//
//  Created by User on 2021/07/16.
//

import UIKit

class SplashController: BaseController {

    // MARK: - Properties
    private let imageView:BaseImageView = BaseImageView(image: UIImage.image(name: .carrot), contentMode: .scaleAspectFit)
    
    private let loadingIndicator:UIActivityIndicatorView = UIActivityIndicatorView(style: .medium)
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        let mainController:StartController = StartController()
        let navController:BaseNavigationController = BaseNavigationController(rootViewController: mainController)
        
        self.view.addSubviews(views: [
            self.imageView, self.loadingIndicator
        ])
        
        self.hideNavBar()
        self.setupLayouts()
        self.loadingIndicator.startAnimating()

        DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
            let window = UIApplication.shared.windows.first ?? UIWindow()
            window.rootViewController = navController
            window.makeKeyAndVisible()
        })
    }
    
    // MARK: - Function
    override func setupLayouts() {
        NSLayoutConstraint.activate([
            self.imageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.imageView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            self.imageView.widthAnchor.constraint(equalToConstant: 250),
            self.imageView.heightAnchor.constraint(equalToConstant: 250),
        ])
    }
}
