//
//  FindLocationController+tableview.swift
//  Karrot
//
//  Created by User on 2021/07/24.
//

import UIKit

extension FindLocationController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let mainController = PhoneNumverVerificationController()
        
        self.pushViewController(mainController)
    }
}
