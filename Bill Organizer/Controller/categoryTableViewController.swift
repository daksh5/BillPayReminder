//
//  categoryTableViewController.swift
//  Bill Organizer
//
//  Created by Daksh Parikh on 5/26/20.
//  Copyright © 2020 Daksh Parikh. All rights reserved.
//

import UIKit

class categoryTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let categorylist = ["Wifi","phone","water","creditcard","Electricity","Gas","subscription","Other"]
    let Images = [UIImage(named: "wifi"), UIImage(named: "phone"), UIImage(named: "water"), UIImage(named: "creditcard"), UIImage(named: "electricity"), UIImage(named: "gas"), UIImage(named: "subscription"), UIImage(named: "other")]
    var selectcategory: String = ""

    @IBOutlet weak var category_table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.category_table.dataSource = self
        self.category_table.rowHeight = 80
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        categorylist.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "category_cell")! as! category_TableViewCell
        
        cell.category_name?.text = categorylist[indexPath.row]
        cell.i?.image = Images[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        selectcategory = self.categorylist[indexPath.row]
        self.performSegue(withIdentifier: "info_category", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "info_category" {
        
            let info = segue.destination as! SubCategoryTableViewController
            
            info.cateory_string = selectcategory
            
        }
        
        
    }
    


}
