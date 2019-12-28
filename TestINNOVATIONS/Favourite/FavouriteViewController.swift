//
//  FavouriteViewController.swift
//  TestINNOVATIONS
//
//  Created by dewill on 28.12.2019.
//  Copyright © 2019 lilcappucc. All rights reserved.
//

import UIKit
import CoreData

class FavouriteViewController: UIViewController {

    //MARK:-> Outlets
    @IBOutlet weak var tableView: UITableView!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var fetchedResultsController:  NSFetchedResultsController<Declaration>?
    
    
    
    //MARK:-> Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
          registerCell()
        setupTableView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        self.fetchData()
    }
    
        // MARK:-> Setup UI
    private func setupNavigationBar(){
        title = "Favourite"
    }
    
    private func registerCell(){
           tableView.register(UINib(nibName: "FavouriteTableViewCell", bundle: nil), forCellReuseIdentifier: FavouriteTableViewCell.description())
       }
    
    private func setupTableView(){
           tableView.delegate = self
           tableView.dataSource = self
    
       }
    
    private func fetchData(){
        if fetchedResultsController == nil {
                  let request: NSFetchRequest<Declaration> = Declaration.fetchRequest()
                  let sort = NSSortDescriptor(key: "firstName", ascending: false)
                  request.sortDescriptors = [sort ]
            fetchedResultsController  = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
//                  fetchedResultsController?.delegate = self
              }
              do {
                  try fetchedResultsController?.performFetch()
                  tableView.reloadData()
              } catch {
                  print("ViewController.loadSaveDate \(error.localizedDescription)")
              }
    }

}


//MARK: -> UITableViewDelegate, UITableViewDataSource
extension FavouriteViewController: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
           return fetchedResultsController?.sections?.count ?? 0
       }
       
       func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           let sectionInfo = fetchedResultsController!.sections![section]
           return sectionInfo.numberOfObjects
       }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavouriteTableViewCell.description(), for: indexPath) as! FavouriteTableViewCell
//        cell.delegate = self
        let currentItem = fetchedResultsController!.object(at: indexPath)
        let name = "\(currentItem.firstName!) \(currentItem.lastName! )"
        cell.setupCell(comment: currentItem.comment ?? "", name: name, companyName: currentItem.placeOfWork!, position: currentItem.position ?? hasNotPositionText, link: currentItem.linkPDF)
        return cell
    }
    
}
