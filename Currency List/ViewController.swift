//
//  ViewController.swift
//  Currency List
//
//  Created by Georgy Khaydenko on 21.05.2018.
//  Copyright © 2018 Georgy Khaydenko. All rights reserved.
//

//test task for Resultant

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var timer = Timer()
    var dataSource : CurrencyDataSource
    var currencies : [Currency] = []
    
    required init?(coder aDecoder: NSCoder) {
        let currencies = [Currency(name: "name", volume: "volume", amount: "amount")]
        self.dataSource = CurrencyDataSource(currencies: currencies)
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 50
        tableView.estimatedRowHeight = 50
        reloadData()
        timer = Timer.scheduledTimer(timeInterval: 15, target: self, selector: #selector(ViewController.reloadData), userInfo: nil, repeats: true)

    }
    
    @IBAction func renewData(_ sender: Any) {
        reloadData()
    }
    
    @objc func reloadData(){
        getCurrencyData()
        dataSource = CurrencyDataSource(currencies: currencies)
        tableView.dataSource = dataSource
        tableView.reloadData()
        currencies.removeAll()
    }
    
    func getCurrencyData(){
        if let url = URL(string: "http://phisix-api3.appspot.com/stocks.json") {
            let task = URLSession.shared.dataTask(with: url) { (data, responce, error) in
                if error != nil {
                    print(error as Any)
                } else {
                    if let urlContent = data {
                        do {
                            let jsonResult = try JSONSerialization.jsonObject(with: urlContent, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                            if let stock = jsonResult["stock"] as? NSArray {
                                for element in stock {
                                    if let currency = element as? NSDictionary {
                                        
                                        var currentName = ""
                                        var currentAmount = ""
                                        var currentVolume = ""
                                        
                                        if let name = currency["name"] as? String {
                                            currentName = name
                                        }
                                        if let price = currency["price"] as? NSDictionary {
                                            if let amount = price["amount"] as? Double {
                                                currentAmount = String(format: "%.2f", amount)
                                            }
                                        }
                                        if let volume = currency["volume"] as? Int{
                                            currentVolume = String(volume)
                                        }
                                        self.currencies.append(Currency(name: currentName, volume: currentVolume, amount: currentAmount))
                                    }
                                }
                            }
                        } catch {
                            print("JSON processing failed")
                        }
                    }
                }
            }
            task.resume()
        }
    }
    
}
