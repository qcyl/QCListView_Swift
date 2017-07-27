//
//  DemoCell.swift
//  QCListView_Swift
//
//  Created by qi chao on 2017/7/27.
//  Copyright © 2017年 CocoaPods. All rights reserved.
//

import UIKit
import QCListView_Swift

class DemoCell: UITableViewCell {

    @IBOutlet weak var countL: UILabel!
    
}

extension DemoCell: TableViewCellDelegate {
    func setObject(_ object: TableViewBaseItem) {
        guard let object = object as? DemoModel else {
            return
        }
        countL.text = String(describing: object.count)
    }
    func tableView(_ tableView: TableView, rowHeightForObject object: TableViewBaseItem) -> CGFloat {
        return 60
    }
}
