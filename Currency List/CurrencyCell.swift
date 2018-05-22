//
//  CurrencyCell.swift
//  Currency List
//
//  Created by Georgy Khaydenko on 21.05.2018.
//  Copyright © 2018 Georgy Khaydenko. All rights reserved.
//

import UIKit

class CurrencyCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var volumeLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    
    var name : String? {
        didSet {
            nameLabel.text = name
        }
    }
    
    var volume : String? {
        didSet {
            volumeLabel.text = volume
        }
    }
    
    var amount : String? {
        didSet {
            amountLabel.text = amount
        }
    }

}
