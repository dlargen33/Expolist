//
//  GroceryListCell.swift
//  Expolist
//
//  Created by Donald Largen on 5/4/24.
//

import UIKit

class GroceryListsCell: UITableViewCell, Reusable {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var itemCountLabel: UILabel!
    
    func configure(name: String, itemCount: Int) {
        nameLabel.text = name
        itemCountLabel.text = "\(itemCount)"
    }
}
