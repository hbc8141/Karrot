//
//  BaseImageView.swift
//  Supermarket
//
//  Created by User on 2021/07/05.
//

import UIKit

class BaseImageView: UIImageView {
    
    // MARK: - Life Cycle
    init(image:Image? = nil, contentMode: UIView.ContentMode = .scaleToFill) {
        super.init(frame: .zero)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.contentMode = contentMode
        
        if let image:Image = image {
            self.image = UIImage(named: image.rawValue)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Function
}
