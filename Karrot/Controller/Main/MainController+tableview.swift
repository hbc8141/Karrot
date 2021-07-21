//
//  MainController+tableview.swift
//  Karrot
//
//  Created by User on 2021/07/16.
//

import UIKit

extension MainController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = self.items[indexPath.row]

        let controller:ItemDetailController = ItemDetailController()
        controller.item = item

        self.navigationController?.pushViewController(controller, animated: true)
    }
}
