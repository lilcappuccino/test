//
//  ViewController.swift
//  TestINNOVATIONS
//
//  Created by dewill on 23.12.2019.
//  Copyright © 2019 lilcappucc. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    private var timer : Timer?
    private var fetchData = NetworkDataFetcher()
    private var data = [ItemResponseModel]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    // MARK:-> IBOutlet
    @IBOutlet weak var tableView: UITableView!
    var loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        return indicator
    }()
    let webview = WKWebView(frame: UIScreen.main.bounds)
    
    
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
        tableView.backgroundView  = loadingIndicator
    }
    
    private func loadingSucces(apiData: [ItemResponseModel]){
        self.data.append(contentsOf: apiData)
        stopLoading()
        tableView.reloadData()
    }
    
    private func showErrorDialog(error: Error? ){
        stopLoading()
        let title = error?.localizedDescription ?? "щось пішло не так"
        let errorDialog = UIAlertController(title: title, message: "", preferredStyle: .alert)
        let alertAcrion = UIAlertAction(title: "Зрозуміло", style: .cancel, handler: nil)
        errorDialog.addAction(alertAcrion)
        present(errorDialog, animated: true, completion: nil)
    }
    
    private func startLoading(){
        tableView.separatorStyle = .none
        loadingIndicator.startAnimating()
    }
    
    private  func stopLoading(){
        self.loadingIndicator.stopAnimating()
        self.tableView.separatorStyle = .singleLine
    }
    
    //MARK: -> DB operations
    
    private func saveDeclarationToDB(item: ItemResponseModel, text: String){
        Declaration.add(id: item.id, firstName: item.firstname, lastName: item.lastname, placeOfWork: item.placeOfWork, position: item.position ?? hasNotPositionText, linkPDF: item.linkPDF ?? "", in: context)
    }
    
    
    //MARK:-> Actions
    private func openViewForPDFReading(by urlString: String){
        let vc = WebViewViewController()
        vc.link = urlString
        present(vc, animated: true, completion: nil)
    }
    
    private func showAddToFavDialog(saving item: ItemResponseModel){
        let comentDialog = UIAlertController(title: "Додати коментар", message: nil, preferredStyle: .alert)
        comentDialog.addTextField(configurationHandler: nil)
      
        comentDialog.addAction(UIAlertAction(title: "Скасувати", style: .cancel, handler: nil))
        comentDialog.addAction(UIAlertAction(title: "Додати", style: .default, handler: { [weak self] _ in
            self?.saveDeclarationToDB(item: item, text: comentDialog.textFields?.first?.text! ?? "")
            
        }))
        self.present(comentDialog, animated: true, completion: nil)
    }
    
//    func textFieldHandler(textField: UITextField!)
//    {
//        if (textField) != nil {
//            textField.text = ""
//        }
//    }
    
}

//MARK:-> UISearchBarDelegate
extension ViewController: UISearchBarDelegate {
    
    ///Can use Rx for better result
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        timer?.invalidate()
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.9, repeats: false, block: {_ in
            print(searchText)
            self.startLoading()
            self.data.removeAll()
            self.fetchData.fetchDeclarations(searchTerm: searchText) { [weak self] (responseData) in
                guard let response = responseData, let self = self  else { return }
                switch response {
                case .success( let value): self.loadingSucces(apiData: value.items)
                case.failure(let value): self.showErrorDialog(error: value)
                }
                
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
        cell.delegate = self
        let currentItem = data[indexPath.row]
        cell.isFavourite = Declaration.isExsiting(by: currentItem.id, in: context)
        cell.cellItem = currentItem
        return cell
    }
    
}

//MARK: -> DeclarationCellDelegate
extension ViewController : DeclarationCellDelegate {
    func addToFavTapped(item: ItemResponseModel) {
        showAddToFavDialog(saving: item)
    }
    
    func openPdfTapped(url: String) {
        openViewForPDFReading(by: url)
    }
    
    
    
    
}
