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
    private var fetchData = NetworkDataFetcher()
    private var data = [ItemResponseModel]()
    
    // MARK:-> IBOutlet
    @IBOutlet weak var tableView: UITableView!
    
    
    // MARK:-> Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupSearchbar()
        registerCell()
        setupTableView()
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
    
    private func setupTableView(){
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    
}

//MARK:-> UISearchBarDelegate
extension ViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        timer?.invalidate()
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.7, repeats: false, block: {_ in
            print(searchText)
            self.fetchData.fetchDeclarations(searchTerm: searchText) { [weak self] (responseData) in
                guard let response = responseData, let self = self  else { return }
                self.data = response.items
                self.tableView.reloadData()
            }
        })
        
    }
}

//MARK: -> UITableViewDelegate, UITableViewDataSource
extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DeclarationTableViewCell.description(), for: indexPath) as! DeclarationTableViewCell
        let currentItem = data[indexPath.item]
        cell.name.text = "\(currentItem.firstname) \(currentItem.lastname)"
        cell.companyName.text = currentItem.placeOfWork
        cell.position.text = currentItem.position
    
        return cell
    }
    
    
    
    
}
