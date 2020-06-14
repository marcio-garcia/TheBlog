//
//  ListingDelegate.swift
//  TheBlog
//
//  Created by Marcio Garcia on 14/06/20.
//  Copyright © 2020 Oxl Tech. All rights reserved.
//

import UIKit

class ListingDelegate<TableViewCellType: ListingTableViewCell>: NSObject, UITableViewDelegate {

    typealias didSelectRowHandlerType = (TableViewCellType) -> Void
    typealias didScrollHandlerType = () -> Void

    var heightForRow: CGFloat?
    var didSelectRowHandler: didSelectRowHandlerType?
    var didScrollHandler: didScrollHandlerType?
    var prefetching: Bool = false

    init(heightForRow: CGFloat?, didSelectRowHandler: didSelectRowHandlerType?, didScrollHandler: didScrollHandlerType?) {
        self.heightForRow = heightForRow
        self.didSelectRowHandler = didSelectRowHandler
        self.didScrollHandler = didScrollHandler
    }

    // MARK: Pagination

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard prefetching == false else { return }
        let actualPosition: CGFloat = scrollView.contentOffset.y
        let contentHeight: CGFloat = scrollView.contentSize.height - (scrollView.frame.size.height)
        if (actualPosition >= contentHeight) {
            DispatchQueue.global().async {
                self.prefetching = true
                self.didScrollHandler?()
            }
         }
    }

    func endFetching() {
        self.prefetching = false
    }

    //MARK: UITableViewDelegate

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let height = heightForRow {
            return height
        } else {
            return UITableView.automaticDimension
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let cell = tableView.cellForRow(at: indexPath) as? TableViewCellType {
            didSelectRowHandler?(cell)
        }
    }
}
