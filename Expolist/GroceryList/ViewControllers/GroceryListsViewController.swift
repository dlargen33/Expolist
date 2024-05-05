//
//  GroceryListViewController.swift
//  Expolist
//
//  Created by Donald Largen on 5/2/24.
//

import UIKit
import Combine

class GroceryListsViewController: UIViewController, Reusable {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var noItemsView: UIView!
    @IBOutlet weak var addListButton: UIButton!
    
    private let viewModel = GroceryListsViewModel()
    private var cancellables = Set<AnyCancellable>()
    
    class func get() -> GroceryListsViewController {
        return GroceryListsViewController.fromNib()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bind()
        viewModel.load()
    }
    
    private func setupUI() {
        self.title = "Grocery Lists"
        noItemsView.isHidden = true
        tableView.isHidden = false
    
        let image = UIImage(systemName: "plus.square.on.square")?.withTintColor(.white)
        let barItem = UIBarButtonItem(image: image,
                                      style: .plain,
                                      target: self,
                                      action: #selector(self.addButtonTouched(_:)))
        self.navigationItem.rightBarButtonItem = barItem
        tableView.registerReusableCell(type: GroceryListCell.self)
    }
    
    private func bind() {
        tableView.dataSource = self
        tableView.delegate = self
        
        viewModel.locationsSubject.sink { [weak self]() in
            guard let self else { return }
            guard self.viewModel.numberOfItems > 0 else {
                self.noItemsView.isHidden = false
                self.tableView.isHidden = true
                return
            }
            self.noItemsView.isHidden = true
            self.tableView.isHidden = false
            self.tableView.reloadData()
            
        }.store(in: &cancellables)
        
        addListButton.addTarget(self,
                                action: #selector(self.addButtonTouched(_:)),
                                for: .touchUpInside)
    }
    
    @objc private func addButtonTouched(_ sender: Any) {
        let alertController = UIAlertController(title: "Add New Grocery List",
                                                message: "",
                                                preferredStyle: .alert)
    
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Enter List Name"
        }
        
        let saveAction = UIAlertAction(title: "Save", style: .default) { [weak self] action in
            
            guard let self = self,
                  let listNameTextField = alertController.textFields?[0],
                  let name = listNameTextField.text else { return }
            
            print("name \(listNameTextField.text ?? "")" )
            let newList = GroceryList(name: name)
            self.viewModel.addList(list: newList)
        }
    
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .default,
                                         handler: { (action : UIAlertAction!) -> Void in })

        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
}

extension GroceryListsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItems
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: GroceryListCell = tableView.dequeueReusableCell(indexPath: indexPath)
        let list = viewModel.list(at: indexPath.row)
        cell.configure(name: list.name,
                       itemCount: list.items.count)
        return cell
    }
}

extension GroceryListsViewController: UITableViewDelegate {
    
}
