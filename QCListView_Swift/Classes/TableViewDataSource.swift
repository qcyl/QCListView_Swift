//
//  TableViewDataSource.swift
//  QCListView_Swift
//
//  Created by qi chao on 2017/3/13.
//
//

import UIKit

public protocol TableViewDataSourceProtocol: UITableViewDataSource {

    func tableView(_ tableView: UITableView, objectForRowAtIndexPath indexPath: IndexPath) -> TableViewBaseItem

}

open class TableViewDataSource: NSObject {

    public var sections: [SectionObject] = []

}

extension TableViewDataSource: TableViewDataSourceProtocol {

    public func tableView(_ tableView: UITableView, objectForRowAtIndexPath indexPath: IndexPath) -> TableViewBaseItem {
        if sections.count > indexPath.section {
            let sectionObject = sections[indexPath.section]
            if sectionObject.items.count > indexPath.row {
                return sectionObject.items[indexPath.row]
            }
        }
        return TableViewBaseItem()
    }

    public func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if sections.count > section {
            let sectionObject = sections[section]
            return sectionObject.items.count
        }
        return 0
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let object = self.tableView(tableView, objectForRowAtIndexPath: indexPath)
        let className = object.itemIdentifier

        let cell = tableView.dequeueReusableCell(withIdentifier: className, for: indexPath)

        if let pro = cell as? TableViewCellDelegate {
            pro.setObject(object)
        }

        return cell
    }
}
