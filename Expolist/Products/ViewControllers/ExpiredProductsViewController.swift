//
//  ExpiredProductsViewController.swift
//  Expolist
//
//  Created by Donald Largen on 4/27/24.
//

import UIKit

class ExpiredProductsViewController: UIViewController, Reusable {

    private let viewModel = ExpiredProductsViewModel()
    
    @IBOutlet weak var tableView: UITableView!
    
    class func get() -> ExpiredProductsViewController {
        return ExpiredProductsViewController.fromNib()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        viewModel.load()
        tableView.reloadData()
    }
    
    private func setupUI() {
        self.title = "Expired Food"
        tableView.registerReusableCell(type: ProductTableCell.self)
        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension ExpiredProductsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, 
                   numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfProducts
    }
    
    func tableView(_ tableView: UITableView, 
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let product = viewModel.product(at: indexPath.row) else { return UITableViewCell() }
        
        let cell: ProductTableCell = tableView.dequeueReusableCell(indexPath: indexPath)
        cell.configure(product: product)
        return cell
    }
}

extension ExpiredProductsViewController: UITableViewDelegate {
    
}
