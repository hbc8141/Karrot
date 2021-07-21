//
//  BaseNavigationController.swift
//  Karrot
//
//  Created by User on 2021/07/16.
//

import UIKit

class BaseNavigationController: UINavigationController {
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationBar.setBackgroundImage(UIImage(), for: .default)
        
        
        self.view.backgroundColor = .white
        // Do any additional setup after loading the view.
    }
}
