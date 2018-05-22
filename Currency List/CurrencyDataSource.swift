//
//  CurrencyDataSource.swift
//  Currency List
//
//  Created by Georgy Khaydenko on 21.05.2018.
//  Copyright © 2018 Georgy Khaydenko. All rights reserved.
//

import Foundation
import UIKit

class CurrencyDataSource: NSObject {
    
    let currencies : [Currency]
    
    init(currencies : [Currency]) {
        self.currencies = currencies
    }
}

extension CurrencyDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currencies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CurrencyCell.self)) as! CurrencyCell
        let currency = currencies[indexPath.row]
        cell.name = currency.name
        cell.volume = currency.volume
        cell.amount = currency.amount
        return cell
    }
}
