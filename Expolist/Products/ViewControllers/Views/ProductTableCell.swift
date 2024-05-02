//
//  ProductTableCell.swift
//  Expolist
//
//  Created by Donald Largen on 4/27/24.
//

import UIKit

class ProductTableCell: UITableViewCell, Reusable {
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var expirationLabel: UILabel!
    @IBOutlet weak var qtyLabel: UILabel!
    
    func configure(product: Product) {
        self.descriptionLabel.text = "\(product.description) - \(product.quantity)"
        self.expirationLabel.text = DateFormatter.basic.string(from: product.expiration)
    }
}
