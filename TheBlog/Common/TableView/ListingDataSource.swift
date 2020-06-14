//
//  ListingDataSource.swift
//  TheBlog
//
//  Created by Marcio Garcia on 14/06/20.
//  Copyright © 2020 Oxl Tech. All rights reserved.
//

import UIKit

protocol ListingTableViewCell: UITableViewCell {
    associatedtype ModelType
    static var identifier: String { get }
    func configure(imageWorker: ImageWorkLogic?, data: ModelType)
    func selected() -> ModelType?
}

class ListingDataSource<TableViewCellType: ListingTableViewCell>: NSObject, UITableViewDataSource {

    private var dataList: [TableViewCellType.ModelType] = []
    private var imageWorker: ImageWorkLogic?

    init(imageWorker: ImageWorkLogic?) {
        self.imageWorker = imageWorker
    }

    @discardableResult
    func updateDataList(with content: [TableViewCellType.ModelType]) -> [TableViewCellType.ModelType] {
        dataList.append(contentsOf: content)
        return dataList
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellType.identifier,
                                                    for: indexPath) as? TableViewCellType {

            cell.configure(imageWorker: imageWorker, data: dataList[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }


}
