//
//  ReusableTableView.swift
//  MVC&MVVM
//
//  Created by Nagaraju on 31/12/23.
//

import Foundation
import UIKit

//MARK: - ReusableTableView DataSource
///CustomTableview with Data source Method

class TableViewDataSource<T>:NSObject,UITableViewDataSource {
  
    var data : [T]
    var cellIdentifier: String
    var numberOfSections: Int
    var heightForRow: CGFloat
    var configureCell: (UITableViewCell, T) -> Void

    init(data: [T], cellIdentifier: String, numberOfSections: Int, heightForRow: CGFloat, configureCell: @escaping (UITableViewCell, T) -> Void) {
        self.data = data
        self.cellIdentifier = cellIdentifier
        self.numberOfSections = numberOfSections
        self.heightForRow = heightForRow
        self.configureCell = configureCell
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
           let item = data[indexPath.row]
           configureCell(cell, item)
           return cell
       }
   
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           return heightForRow
    }
}

//MARK: - ReusableTableView TableViewDelegate

class TableViewDelegate: NSObject, UITableViewDelegate {
    var didSelectRow: (IndexPath) -> Void

    init(didSelectRow: @escaping (IndexPath) -> Void) {
        self.didSelectRow = didSelectRow
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelectRow(indexPath)
    }
}
