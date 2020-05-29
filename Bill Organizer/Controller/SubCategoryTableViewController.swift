//
//  SubCategoryTableViewController.swift
//  Bill Organizer
//
//  Created by Daksh Parikh on 5/26/20.
//  Copyright © 2020 Daksh Parikh. All rights reserved.
//

import UIKit

class SubCategoryTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    

    @IBOutlet weak var categoryType: UILabel!
    
    @IBOutlet weak var table: UITableView!
    
    var cateory_string: String = ""
    var reminderdata: [Reminder] = []
    var categorydata: [Reminder] = []
    
    func loaddata(){
        let urlString = "http://localhost:8080/usersList"
        
        do{
            let url = URL(string: urlString)!
            var request = URLRequest(url: url)
            request.addValue("application/json", forHTTPHeaderField: "Accept")

            let session = URLSession.shared

            let task = session.dataTask(with: url) { data, response, error in
                do{
                    let json = try JSONSerialization.jsonObject(with: data!) as! NSArray
                    for anObject  in json as! [Dictionary<String, Any>]{
                        
                        let reminder: Reminder = Reminder(
                            name: anObject["name"] as! String,
                            amount: anObject["amount"] as! Int,
                            date: anObject["due_date"] as! String,
                            category: anObject["category"] as! String,
                            id: anObject["_id"] as! String)
                        
                        self.reminderdata.append(reminder)
                        
                        
                    }
                    for i in self.reminderdata{
                        if i.category==self.cateory_string{
                            self.categorydata.append(i)
                        }
                    }
    
                    DispatchQueue.main.async {
                        self.table.reloadData()
                    }
                }
                catch {
                    print("JSON error: \(error.localizedDescription)")
                }
            }
            task.resume()
            
        }

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = cateory_string
        
        
        //categoryType.text? = cateory_string
        
        self.loaddata()
        
        
        DispatchQueue.main.async {
            self.table.reloadData()
        }
        
        self.table.dataSource = self
        self.table.rowHeight = 80
    }
    
    
    var selectid: String = ""
    var selectname: String = ""
    var selectamount: Int = 0
    var selectdate: String = ""
    var selectcategory: String = ""
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        selectid = self.categorydata[indexPath.row].id
        selectname = self.categorydata[indexPath.row].name
        selectamount = self.categorydata[indexPath.row].amount
        selectdate = self.categorydata[indexPath.row].date
        selectcategory = self.categorydata[indexPath.row].category
        self.performSegue(withIdentifier: "subcategory_to_info", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "subcategory_to_info" {
        
            let info = segue.destination as! ReminderInfo
            info.id_string = selectid
            info.name_string = selectname
            info.amount_int = selectamount
            info.date_string = selectdate
            info.cateory_string = selectcategory
            
        }
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.categorydata.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "subcategory_cell")! as! SubCategory_TableViewCell
        
         
         let name = self.categorydata[indexPath.row].name
         let amount = self.categorydata[indexPath.row].amount
         let date = self.categorydata[indexPath.row].date
         let category = self.categorydata[indexPath.row].category
         
         cell.name?.text = name
         cell.amount?.text = String(amount)
         cell.date?.text = date
         cell.category?.text = category
         
         return cell
    }

}
