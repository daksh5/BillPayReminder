//
//  main_TableViewCell.swift
//  Bill Organizer
//
//  Created by Daksh Parikh on 3/29/20.
//  Copyright © 2020 Daksh Parikh. All rights reserved.
//

import UIKit

class main_TableViewCell: UITableViewCell {

    @IBOutlet weak var name_label: UILabel!
    
    @IBOutlet weak var amount_label: UILabel!
    
    @IBOutlet weak var date_label: UILabel!
    
    @IBOutlet weak var category_label: UILabel!
    
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }

}
