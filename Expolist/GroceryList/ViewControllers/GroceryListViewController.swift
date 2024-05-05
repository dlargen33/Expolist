//
//  GroceryListViewController.swift
//  Expolist
//
//  Created by Donald Largen on 5/4/24.
//

import UIKit
import Combine

protocol GroceryListViewControllerDelegate: AnyObject {
    func itemAdded()
}

class GroceryListViewController: UIViewController, Reusable {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var noItemsView: UIView!
    
    private var viewModel: GroceryListViewModel!
    private var cancellables = Set<AnyCancellable>()
    weak var delegate: GroceryListViewControllerDelegate?
    
    class func get(list: GroceryList) -> GroceryListViewController {
        let vc: GroceryListViewController = GroceryListViewController.fromNib()
        vc.viewModel = GroceryListViewModel(list: list)
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bind()
    }
    
    func setupUI() {
        title = viewModel.title
        tableView.registerReusableCell(type: GroceryListCell.self)
        
        navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "",
                                                                                         style: .plain,                     target: nil,
                                                                                         action: nil)
        let image = UIImage(systemName: "plus.square.on.square")?.withTintColor(.white)
        let barItem = UIBarButtonItem(image: image,
                                      style: .plain,
                                      target: self,
                                      action: #selector(self.addButtonTouched(_:)))
        self.navigationItem.rightBarButtonItem = barItem
    }
    
    func bind() {
        tableView.dataSource = self
        noItemsView.isHidden = viewModel.numberOfItems > 0
        tableView.isHidden = viewModel.numberOfItems <= 0
        
        //bind to subject.
        viewModel.itemAdded.sink { [weak self] in
            guard let self else { return }
            self.tableView.isHidden = false
            self.noItemsView.isHidden = true
            self.tableView.reloadData()
            self.delegate?.itemAdded()
        }.store(in: &cancellables)
        
       if viewModel.numberOfItems > 0 {
            tableView.reloadData()
        }
        
        addButton.addTarget(self,
                            action: #selector(self.addButtonTouched(_:)),
                            for: .touchUpInside)
    }
    
    @objc private func addButtonTouched(_ sender: Any) {
        let alertController = UIAlertController(title: "Add New Grocery Item",
                                                message: "",
                                                preferredStyle: .alert)
    
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Enter Item Name"
        }
        
        alertController.addTextField { textField in
            textField.placeholder = "Enter Item Quantity"
        }
        
        let saveAction = UIAlertAction(title: "Add", style: .default) { [weak self] action in
            guard let self = self,
                  let itemNameTxtField = alertController.textFields?[0],
                  let quantityTxtField = alertController.textFields?[1],
                  let name = itemNameTxtField.text,
                  !name.isEmpty,
                  let qty = quantityTxtField.text,
                  !qty.isEmpty else { return }
            
            let item = GroceryItem(name: name, quantity: qty)
            self.viewModel.add(item: item)
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

extension GroceryListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItems
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: GroceryListCell = tableView.dequeueReusableCell(indexPath: indexPath)
        let item = viewModel.item(at: indexPath.row)
        cell.configure(name: item.name,
                       quantity: item.quantity)
        return cell
    }
}
