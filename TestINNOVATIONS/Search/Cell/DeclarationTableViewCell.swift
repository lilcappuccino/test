//
//  DeclarationTableViewCell.swift
//  TestINNOVATIONS
//
//  Created by dewill on 23.12.2019.
//  Copyright © 2019 lilcappucc. All rights reserved.
//

import UIKit

protocol DeclarationCellDelegate {
    func openPdfDidTapped(url: String)
    func addToFavDidTapped(item: ItemResponseModel)
}


class DeclarationTableViewCell: UITableViewCell {

    //MARK:-> Outlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var companyNameLabel: UILabel!
    @IBOutlet weak var positionLabel: UILabel!
    @IBOutlet weak var addToFavButton: UIButton!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var openPdfButton: UIButton!
    
    var cellItem: ItemResponseModel? {
        didSet {
            guard let item = cellItem else { return }
            let name = "\(item.firstname) \(item.lastname)"
            setupCell(name: name, companyName: item.placeOfWork, position: item.position ?? hasNotPositionText, link: item.linkPDF)
        }
    }
    var isFavourite = false {
        didSet {
            isAddedToFavoutire()
        }
    }
    var delegate: DeclarationCellDelegate?
    
    
    //MARK: -> Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    //MARK:-> Setup UI
    func setupCell(name: String, companyName: String, position: String, link: String?){
        openPdfButton.isHidden = link == nil ? true : false
        nameLabel.text = name
        companyNameLabel.text = companyName
        if position == hasNotPositionText {
            positionLabel.isHidden = true
        }else {
            positionLabel.isHidden = false
            positionLabel.text = position
            
        }
    }
    
    private func isAddedToFavoutire(){
        if isFavourite{
            addToFavButton.setImage(UIImage(systemName: "star.fill" ), for: .normal)
        }else{
            addToFavButton.setImage(UIImage(systemName: "star" ), for: .normal)
        }
    }
    
    
    //MARK:-> Actions
    @IBAction func openPdfTapped(_ sender: Any) {
        guard let pdfUrl = cellItem?.linkPDF  else { return }
        delegate?.openPdfDidTapped(url: pdfUrl)
    }
    
    @IBAction func addToFavouriteTapped(_ sender: Any) {
        guard let item = cellItem else { return }
        delegate?.addToFavDidTapped(item: item)
        isFavourite = !isFavourite
        isAddedToFavoutire()
    }
    
}
