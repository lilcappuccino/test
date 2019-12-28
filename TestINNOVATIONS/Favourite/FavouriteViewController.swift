//
//  FavouriteViewController.swift
//  TestINNOVATIONS
//
//  Created by dewill on 28.12.2019.
//  Copyright © 2019 lilcappucc. All rights reserved.
//

import UIKit

class FavouriteViewController: UIViewController {

    //MARK:-> Outlets
    @IBOutlet weak var tableView: UITableView!
    
    //MARK:-> Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
    }
    
        // MARK:-> Setup UI
    private func setupNavigationBar(){
        title = "Favourite"
    }

}
