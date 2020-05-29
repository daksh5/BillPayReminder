//
//  SubCategory_TableViewCell.swift
//  Bill Organizer
//
//  Created by Daksh Parikh on 5/26/20.
//  Copyright © 2020 Daksh Parikh. All rights reserved.
//

import UIKit

class SubCategory_TableViewCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var amount: UILabel!
    
    @IBOutlet weak var date: UILabel!
    
    @IBOutlet weak var category: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
