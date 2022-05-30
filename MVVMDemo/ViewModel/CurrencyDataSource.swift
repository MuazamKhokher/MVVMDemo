//
//  CurrencyDataSource.swift
//  MVVMDemo
//
//  Created by Muazam on 20/02/2022.
//

import Foundation
import UIKit

class GenericDataSource<T> : NSObject {
    var data: DynamicValue<[T]> = DynamicValue([])
}

class CurrencyDataSource : GenericDataSource<CurrencyRate>, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CurrencyCell", for: indexPath) as! CurrencyCell
        cell.currencyRate = self.data.value[indexPath.row]
        cell.tag = indexPath.row
        return cell
    }
}
