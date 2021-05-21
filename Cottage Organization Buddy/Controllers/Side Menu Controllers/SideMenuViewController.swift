//
//  SideMenuViewController.swift
//  Cottage Organization Buddy
//
//  Created by Philip D'Aloia on 2021-05-19.
//

import UIKit

private let reuseIdentifier = "sideMenuOptionCell"

class SideMenuViewController: UIViewController {
    
    //MARK: - Properties
    var tableView: UITableView!
    
    var cottageTabsDelegate: SideMenuButtonDelegate?
    
    //MARK: - Init

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .lightGray
        configureTableView()
    }
    
    //MARK: - Handlers
    
    func configureTableView() {
        
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(SideMenuTableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        
        tableView.backgroundColor = .lightGray
        tableView.separatorStyle = .none
        tableView.rowHeight = 80
        
        self.view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        
    }

}

extension SideMenuViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! SideMenuTableViewCell
        
        let sideMenuOption = SideMenuOption(rawValue: indexPath.row)
        cell.descriptionLabel.text = sideMenuOption?.description
        cell.iconImageView.image = sideMenuOption?.image
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 4
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let sideMenuOption = SideMenuOption(rawValue: indexPath.row)
        cottageTabsDelegate?.handleMenuToggle(forMenuOption: sideMenuOption)
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
}
