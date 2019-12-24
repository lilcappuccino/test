//
//  DeclarationTableViewCell.swift
//  TestINNOVATIONS
//
//  Created by dewill on 23.12.2019.
//  Copyright © 2019 lilcappucc. All rights reserved.
//

import UIKit

class DeclarationTableViewCell: UITableViewCell {
    //MARK:-> Outlets
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var companyName: UILabel!
    @IBOutlet weak var position: UILabel!
    
    
    //MARK: -> Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
