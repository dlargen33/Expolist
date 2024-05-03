//
//  GroceryListViewController.swift
//  Expolist
//
//  Created by Donald Largen on 5/2/24.
//

import UIKit
import Combine

class GroceryListViewController: UIViewController, Reusable {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var noItemsView: UIView!
    @IBOutlet weak var addListButton: UIButton!
    
    private let viewModel = GroceryListViewModel()
    private var cancellables = Set<AnyCancellable>()
    
    class func get() -> GroceryListViewController {
        return GroceryListViewController.fromNib()
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
    }
    
    private func bind() {
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
        print("add pressed")
    }
}

extension GroceryListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

extension GroceryListViewController: UITableViewDelegate {
    
}
