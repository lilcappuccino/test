//
//  FavouriteTableViewCell.swift
//  TestINNOVATIONS
//
//  Created by dewill on 28.12.2019.
//  Copyright © 2019 lilcappucc. All rights reserved.
//

import UIKit

class FavouriteTableViewCell: UITableViewCell {
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var positionLabel: UILabel!
    @IBOutlet weak var editCommentBtn: UIButton!
    @IBOutlet weak var openPdfBtn: UIButton!
    @IBOutlet weak var addToFavButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func editCommentDidTapped(_ sender: Any) {
    }
    @IBAction func openPdfDidTapped(_ sender: Any) {
    }
    @IBAction func removeFromFavTapped(_ sender: Any) {
    }
    
}
