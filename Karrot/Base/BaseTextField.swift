//
//  BaseTextField.swift
//  Karrot
//
//  Created by User on 2021/07/22.
//

import UIKit

class BaseTextField: UITextField {

    // MARK: - Life Cycle
    init(text: String? = nil, placeholder: String? = nil) {
        super.init(frame: .zero)

        self.translatesAutoresizingMaskIntoConstraints = false
        self.placeholder = placeholder
        self.text = text
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
