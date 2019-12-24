//
//  ViewController.swift
//  TestINNOVATIONS
//
//  Created by dewill on 23.12.2019.
//  Copyright © 2019 lilcappucc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private var timer : Timer?
    
    // MARK:-> IBOutlet
    @IBOutlet weak var tableView: UITableView!
    
    
    // MARK:-> Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupSearchbar()
        registerCell()
    }
    
    // MARK:-> Setup UI
    private func setupNavigationBar(){
        title = "Marchenko"
    }
    
    private func setupSearchbar(){
           let searchController = UISearchController(searchResultsController: nil)
           searchController.hidesNavigationBarDuringPresentation = false
           searchController.obscuresBackgroundDuringPresentation = false
                navigationItem.searchController = searchController
                searchController.searchBar.delegate = self
       }
    
    private func registerCell(){
        tableView.register(UINib(nibName: "DeclarationTableViewCell", bundle: nil), forCellReuseIdentifier: DeclarationTableViewCell.description())
    }
    
}

//MARK:-> UISearchBarDelegate
extension ViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
           timer?.invalidate()
           
           timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: {_ in
               print(searchText)

           })
       
       }

}
