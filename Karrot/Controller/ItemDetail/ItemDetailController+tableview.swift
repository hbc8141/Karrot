//
//  ItemDetailController+tableview.swift
//  Karrot
//
//  Created by User on 2021/07/27.
//

import UIKit

extension ItemDetailController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let row:Int = indexPath.row

        switch row {
            case 0:
                return tableView.frame.size.height/2
            default:
                return 50
        }
    }
}
