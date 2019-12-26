//
//  DeclarationTableViewCell.swift
//  TestINNOVATIONS
//
//  Created by dewill on 23.12.2019.
//  Copyright © 2019 lilcappucc. All rights reserved.
//

import UIKit

class DeclarationTableViewCell: UITableViewCell {
    
    let hasNotPositionText = "ні"
    //MARK:-> Outlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var companyNameLabel: UILabel!
    @IBOutlet weak var positionLabel: UILabel!
    @IBOutlet weak var addToFavButton: UIButton!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var openPdfButton: UIButton!
    var link: String?
    
    
    
    //MARK: -> Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
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
    
    
    @IBAction func openPdfTapped(_ sender: Any) {
    }
    @IBAction func addToFavouriteTapped(_ sender: Any) {
    }
    
}
