//
//  CircleMembersViewController.swift
//  Expolist
//
//  Created by Donald Largen on 5/5/24.
//

import UIKit
import Combine

class CircleMembersViewController: UIViewController, Reusable {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var noItemsView: UIView!
    @IBOutlet weak var addButton: UIButton!
    
    private var viewModel = CircleMemberViewModel()
    private var cancellables = Set<AnyCancellable>()
    
    class func get() -> CircleMembersViewController {
        let vc:CircleMembersViewController = CircleMembersViewController.fromNib()
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bind()
        viewModel.load()
    }
    
    private func setupUI() {
        self.title = "Circle Members"
        let image = UIImage(systemName: "plus.square.on.square")?.withTintColor(.white)
        let barItem = UIBarButtonItem(image: image,
                                      style: .plain,
                                      target: self,
                                      action: #selector(self.addButtonTouched(_:)))
        self.navigationItem.rightBarButtonItem = barItem
        tableView.registerReusableCell(type: CircleMemberCell.self)
        
    }
    
    private func bind() {
        tableView.dataSource = self
        
        viewModel.membersSubject.sink { [weak self] in
            guard let self else { return }
            guard self.viewModel.numberOfItems > 0 else {
                self.tableView.isHidden = true
                self.noItemsView.isHidden = false
                return
            }
            
            self.tableView.isHidden = false
            self.noItemsView.isHidden = true
            self.tableView.reloadData()
        }.store(in: &cancellables)
        
        addButton.addTarget(self,
                            action: #selector(self.addButtonTouched(_:)),
                            for: .touchUpInside)
    }
    
    @objc private func addButtonTouched(_ sender: Any) {
        let alertController = UIAlertController(title: "Add Member",
                                                message: "",
                                                preferredStyle: .alert)
    
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Enter Name"
        }
        
        let saveAction = UIAlertAction(title: "Save", style: .default) { [weak self] action in
            guard let self = self,
                  let nameTextField = alertController.textFields?[0],
                  let name = nameTextField.text else { return }
            
            let newMember = CircleMember(name: name)
            self.viewModel.addMember(member: newMember)
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

extension CircleMembersViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItems
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CircleMemberCell = tableView.dequeueReusableCell(indexPath: indexPath)
        let member = viewModel.item(at: indexPath.row)
        cell.nameLabel.text = member.name
        return cell
    }
}

extension CircleMembersViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        
        //show screen that will allow the user to associate a list with a list of users.
    }
    
}
