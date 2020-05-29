//
//  category_TableViewCell.swift
//  Bill Organizer
//
//  Created by Daksh Parikh on 5/26/20.
//  Copyright © 2020 Daksh Parikh. All rights reserved.
//

import UIKit

class category_TableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var category_name: UILabel!
    
    @IBOutlet var i: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
