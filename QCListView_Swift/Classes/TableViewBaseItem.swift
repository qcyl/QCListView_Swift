//
//  TableViewBaseItem.swift
//  QCListView_Swift
//
//  Created by qi chao on 2017/3/13.
//
//

import UIKit

open class TableViewBaseItem {

    internal static let CellInvalidHeight: CGFloat = -1

    public var itemIdentifier: String
    public var cellHeight: CGFloat

    public init() {
        self.cellHeight = TableViewBaseItem.CellInvalidHeight
        self.itemIdentifier = TableViewBaseItem.dealClassName("\(NSStringFromClass(type(of: self)))")
    }
    
    private static func dealClassName(_ className: String) -> String {
        var className = className
        let dealStrArray = TableViewBaseItem.dealStrArray()

        for item in dealStrArray {
            if className.hasSuffix(item) {
                let index = className.index(className.startIndex, offsetBy: className.characters.count - item.characters.count)
                className = className.substring(to: index)
                break
            }
        }

        className = className + "Cell"
        return className
    }

    private static func dealStrArray() -> [String] {
        guard let path = Bundle.main.path(forResource: "cellIDRule", ofType: "plist") else {
            return ["Model", "Item"]
        }
        return NSArray(contentsOfFile: path) as! [String]
    }

}
