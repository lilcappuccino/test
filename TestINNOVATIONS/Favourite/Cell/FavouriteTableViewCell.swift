//
//  FavouriteTableViewCell.swift
//  TestINNOVATIONS
//
//  Created by dewill on 28.12.2019.
//  Copyright © 2019 lilcappucc. All rights reserved.
//

import UIKit

protocol FavouriteCellDelegate {
    func openPdfDidTapped(url: String)
    func removeFromFavDidTapped(id: String)
    func editCommentDidTapped(id: String, old comemnt: String)
}


class FavouriteTableViewCell: UITableViewCell {
    //MARK:-> Outlets
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var positionLabel: UILabel!
    @IBOutlet weak var editCommentBtn: UIButton!
    @IBOutlet weak var openPdfBtn: UIButton!
    @IBOutlet weak var addToFavButton: UIButton!
    
    private var link: String?
    var delegate: FavouriteCellDelegate?
    private var id: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    //MARK:-> Setup cell
    func setupCell(id: String, comment: String, name: String, companyName: String, position: String, link: String?){
        self.id = id
        commentLabel.text = comment
        self.link = link
        if let currentLink = link  , currentLink.isEmpty {
            openPdfBtn.isHidden = true
        }else {
            openPdfBtn.isHidden = false
        }
        nameLabel.text = name
        companyLabel.text = companyName
        if position == hasNotPositionText {
            positionLabel.isHidden = true
        }else {
            positionLabel.isHidden = false
            positionLabel.text = position
            
        }
    }
    
    //MARK:-> Actions
    @IBAction func editCommentDidTapped(_ sender: Any) {
        guard let currentId = id else { return }
        delegate?.editCommentDidTapped(id: currentId, old:  commentLabel.text ?? "")
    }
    
    @IBAction func openPdfDidTapped(_ sender: Any) {
        guard let pdfLink = link, !pdfLink.isEmpty else { return }
        delegate?.openPdfDidTapped(url: pdfLink)
    }
    
    @IBAction func removeFromFavDidTapped(_ sender: Any) {
        guard let currentId = id else { return }
        delegate?.removeFromFavDidTapped(id: currentId)
    }
    
}
