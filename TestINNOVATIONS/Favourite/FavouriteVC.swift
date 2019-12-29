//
//  FavouriteViewController.swift
//  TestINNOVATIONS
//
//  Created by dewill on 28.12.2019.
//  Copyright © 2019 lilcappucc. All rights reserved.
//

import UIKit
import CoreData

class FavouriteVC: UIViewController {
    
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
    //MARK:-> Database
    private func fetchData(){
        if fetchedResultsController == nil {
            let request: NSFetchRequest<Declaration> = Declaration.fetchRequest()
            let sort = NSSortDescriptor(key: "firstName", ascending: false)
            request.sortDescriptors = [sort ]
            fetchedResultsController  = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
            fetchedResultsController?.delegate = self
        }
        do {
            try fetchedResultsController?.performFetch()
            tableView.reloadData()
        } catch {
            print("ViewController.loadSaveDate \(error.localizedDescription)")
        }
    }
    
    
    //MARK:-> Actions
    private func openViewForPDFReading(by urlString: String){
        let vc = WebViewViewController()
        vc.link = urlString
        present(vc, animated: true, completion: nil)
    }
    
    private func showChangeCommentDialog(declarationId: String, old comment: String){
        let comentDialog = UIAlertController(title: "Змінити коментар", message: nil, preferredStyle: .alert)
        comentDialog.addTextField(configurationHandler: nil)
        comentDialog.textFields?.first?.text = comment
        comentDialog.addAction(UIAlertAction(title: "Скасувати", style: .cancel, handler: nil))
        comentDialog.addAction(UIAlertAction(title: "Додати", style: .default, handler: { [weak self] _ in
            guard let self = self else { return }
            Declaration.self.update(id: declarationId, new: comentDialog.textFields?.first?.text! ?? "", in: self.context)
            self.tableView.reloadData()
            
        }))
        self.present(comentDialog, animated: true, completion: nil)
    }
    
    
}


//MARK: -> UITableViewDelegate, UITableViewDataSource
extension FavouriteVC: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return fetchedResultsController?.sections?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionInfo = fetchedResultsController!.sections![section]
        return sectionInfo.numberOfObjects
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavouriteTableViewCell.description(), for: indexPath) as! FavouriteTableViewCell
        cell.delegate = self
        let currentItem = fetchedResultsController!.object(at: indexPath)
        let name = "\(currentItem.firstName!) \(currentItem.lastName! )"
        cell.setupCell(id: currentItem.id!, comment: currentItem.comment ?? "", name: name, companyName: currentItem.placeOfWork!, position: currentItem.position ?? hasNotPositionText, link: currentItem.linkPDF)
        return cell
    }
    
}

//MARK:-> FavouriteCellDelegate
extension FavouriteVC: FavouriteCellDelegate{
    func editCommentDidTapped(id: String, old comemnt: String) {
        showChangeCommentDialog(declarationId: id, old: comemnt)
    }
    
    func openPdfDidTapped(url: String) {
        openViewForPDFReading(by: url)
    }
    
    func removeFromFavDidTapped(id: String) {
        Declaration.remove(by: id, in: context)
        
    }
    
}


//MARK: -> NSFetchedResultsControllerDelegate
extension FavouriteVC : NSFetchedResultsControllerDelegate {
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        guard let index = indexPath, type == NSFetchedResultsChangeType.delete else { return }
            tableView.deleteRows(at: [index], with: .fade)
    }
}
