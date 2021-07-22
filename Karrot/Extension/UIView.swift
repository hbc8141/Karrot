//
//  UIView.swift
//  Karrot
//
//  Created by User on 2021/07/16.
//

import UIKit

extension UIView {
    func addSubviews(views: [UIView]) -> Void {
        for view in views {
            self.addSubview(view)
        }
    }
}
