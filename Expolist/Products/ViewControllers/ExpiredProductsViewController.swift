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
        let titleLabel = UILabel()
        titleLabel.isUserInteractionEnabled = true
        titleLabel.textColor = .white
        titleLabel.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        titleLabel.text = "Expired Food"
        let longPress = UILongPressGestureRecognizer(target: self,
                                                    action: #selector(self.clearLongPress(sender:)))
        longPress.minimumPressDuration = 2.0
        titleLabel.addGestureRecognizer(longPress)
        
        self.navigationItem.titleView = titleLabel
        
        tableView.registerReusableCell(type: ProductTableCell.self)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    @objc private func clearLongPress(sender: UILongPressGestureRecognizer) {
        if sender.state == .began {
            let alertController = UIAlertController(title: "Clear Saved Data?  This will require restarting the application.",
                                                    message: "",
                                                    preferredStyle: .alert)
        
            let saveAction = UIAlertAction(title: "Clear", style: .default) { [weak self] action in
                guard let self = self else { return }
                self.viewModel.clearAll()
            }
        
            let cancelAction = UIAlertAction(title: "Cancel",
                                             style: .default,
                                             handler: { (action : UIAlertAction!) -> Void in })

            alertController.addAction(saveAction)
            alertController.addAction(cancelAction)
            self.present(alertController,
                         animated: true,
                         completion: nil)
        }
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
