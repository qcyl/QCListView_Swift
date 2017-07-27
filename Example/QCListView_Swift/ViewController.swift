//
//  ViewController.swift
//  QCListView_Swift
//
//  Created by qi chao on 03/13/2017.
//  Copyright (c) 2017 qi chao. All rights reserved.
//

import UIKit
import QCListView_Swift

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tableView = TableView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height), style: .plain)
        tableView.qcDataSource = dataSource
        tableView.qcDelegate = self
        tableView.register(cell: DemoCell())
        tableView.register(cell: Demo2Cell())
        view.addSubview(tableView)
    }
    
    let dataSource: TableViewDataSource = {
        let dataSource = TableViewDataSource()
        
        var section = SectionObject()
        section.items = {
            var items: [TableViewBaseItem] = []
            
            for i in 0..<20 {
                let model = DemoModel()
                model.count = i
                items.append(model)
                let model2 = Demo2Model()
                model2.count2 = i
                items.append(model2)
            }

            return items
        }()
        dataSource.sections = [section]
        
        return dataSource
    }()

}

extension ViewController: TableViewDelegate {
    func tableView(_ tableView: TableView, didSelectedObject object: TableViewBaseItem, atIndexPath indexPatn: IndexPath) {
        print("点击")
    }
}

