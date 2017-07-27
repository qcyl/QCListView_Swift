//
//  Demo2Cell.swift
//  QCListView_Swift
//
//  Created by qi chao on 2017/7/27.
//  Copyright © 2017年 CocoaPods. All rights reserved.
//

import UIKit
import QCListView_Swift

class Demo2Cell: UITableViewCell {

    @IBOutlet weak var countL: UILabel!
    
}

extension Demo2Cell: TableViewCellDelegate {
    func setObject(_ object: TableViewBaseItem) {
        guard let object = object as? Demo2Model else {
            return
        }
        countL.text = String(describing: object.count2)
    }
    func tableView(_ tableView: TableView, rowHeightForObject object: TableViewBaseItem) -> CGFloat {
        return 100
    }
}

