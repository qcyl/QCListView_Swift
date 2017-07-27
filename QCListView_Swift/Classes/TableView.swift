//
//  TableView.swift
//  QCListView_Swift
//
//  Created by qi chao on 2017/3/13.
//
//

import UIKit

public protocol TableViewDelegate: UITableViewDelegate {

    func tableView(_ tableView: TableView, didSelectedObject object: TableViewBaseItem, atIndexPath indexPatn: IndexPath)

}

public extension TableViewDelegate {
    
    func tableView(_ tableView: TableView, didSelectedObject object: TableViewBaseItem, atIndexPath indexPatn: IndexPath){ }
}

public protocol TableViewCellDelegate {
    func setObject(_ object: TableViewBaseItem)
    func tableView(_ tableView: TableView, rowHeightForObject object: TableViewBaseItem) -> CGFloat
}

public class TableView: UITableView {

    public var qcDataSource: TableViewDataSourceProtocol? {
        didSet {
            self.dataSource = qcDataSource
        }
    }
    public var qcDelegate: TableViewDelegate? {
        didSet {
            self.delegate = ProtocolDispatcher.dispatcherProtocol(UITableViewDelegate.self, toImplemertors: [qcDelegate ?? self, self])
        }
    }

    /// 统一注册cell方法
    public func register(cell cls: AnyObject) {
        let identifier = "\(NSStringFromClass(type(of: cls)))"
        let className = "\(type(of: cls))"
        if Bundle.main.path(forResource: className, ofType: "nib") != nil {
            print("cell-->\(className) register from nib")
            let nib = UINib(nibName: className, bundle: nil)
            register(nib, forCellReuseIdentifier: identifier)
        } else {
            print("cell-->\(className) register from class")
            register(cls.classForCoder, forCellReuseIdentifier: identifier)
        }
    }

}

extension TableView: TableViewDelegate {

    public func tableView(_ tableView: TableView, didSelectedObject object: TableViewBaseItem, atIndexPath indexPatn: IndexPath) {

    }

    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let dataSource = tableView.dataSource as? TableViewDataSourceProtocol else {
            return TableViewBaseItem.CellInvalidHeight
        }

        let object = dataSource.tableView(tableView, objectForRowAtIndexPath: indexPath)
        if object.cellHeight == TableViewBaseItem.CellInvalidHeight {   //没有高度缓存
            guard let cls = NSClassFromString(object.itemIdentifier) else {
                assert(false, "class not found,please check classname")
            }
            let realClass = cls as! UITableViewCell.Type
            if let pro = realClass.init() as? TableViewCellDelegate {
                object.cellHeight = pro.tableView(self, rowHeightForObject: object)
            } else {
                print("cell-->\(object.itemIdentifier) 没有实现CellProtocol协议")
            }
        }

        return object.cellHeight
    }

    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let delegate = qcDelegate else {
            return
        }
        guard let dataSource = tableView.dataSource as? TableViewDataSourceProtocol else {
            return
        }
        let object = dataSource.tableView(tableView, objectForRowAtIndexPath: indexPath)
        delegate.tableView(self, didSelectedObject: object, atIndexPath: indexPath)
    }

}
