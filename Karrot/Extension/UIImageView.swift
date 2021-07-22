//
//  UIImage.swift
//  Karrot
//
//  Created by User on 2021/07/18.
//

import UIKit

extension UIImageView {

    // Load image to url
    func loadImage(absoluteUrl: String) -> Void {
        if let url:URL = URL(string: absoluteUrl) {
            do {
                let imageData:Data = try Data(contentsOf: url)
                self.image = UIImage(data: imageData)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

extension UIImage {
    static func image(name: Image) -> UIImage? {
        return UIImage(named: name.rawValue) ?? UIImage()
    }
}
