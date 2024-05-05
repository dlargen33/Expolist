//
//  GroceryListCell.swift
//  Expolist
//
//  Created by Donald Largen on 5/5/24.
//

import UIKit

class GroceryListCell: UITableViewCell, Reusable {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    
    
    func configure(name: String, quantity: String) {
        nameLabel.text = name
        quantityLabel.text = quantity
    }
}
