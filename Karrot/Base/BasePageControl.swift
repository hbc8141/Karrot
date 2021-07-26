//
//  BasePageControl.swift
//  Karrot
//
//  Created by User on 2021/07/26.
//

import UIKit

class BasePageControl: UIPageControl {

    // MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
