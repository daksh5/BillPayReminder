//
//  HomeTableViewController.swift
//  Bill Organizer
//
//  Created by Daksh Parikh on 2/18/20.
//  Copyright © 2020 Daksh Parikh. All rights reserved.
//

import UIKit
import Foundation

class HomeTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var reminderdata: [Reminder] = []
    
    @IBOutlet weak var table: UITableView!
    
    
    @IBAction func postbtn(_ sender: Any) {
        
    }
    
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
                    
                    /*for data in self.reminderdata{
                        //print(data.date)
                        let todaydat = self.todaydate()
                        //print(type(of: todaydat))
                        if todaydat == data.date{
                            
                            print(todaydat)
                            print("got it")
                            
                        }
                    }*/
                    
                    DispatchQueue.main.async {
                        self.table.reloadData()
                    }
                    //self.table.reloadData()
                }
                catch {
                    print("JSON error: \(error.localizedDescription)")
                }
            }
            task.resume()
            
        }

    }
    
    
    func deleteMethod(id : String) {
        guard let url = URL(string: "http://localhost:8080/delete/\(id)") else {
            print("Error: cannot create URL")
            return
        }
        // Create the request
        print("http://localhost:8080/delete/\(id)")
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        URLSession.shared.dataTask(with: request) { data, response, error in
            print(response as Any)
            print(data as Any)
            
        }.resume()
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.loaddata()
        
        
        DispatchQueue.main.async {
            self.table.reloadData()
        }
        
        self.table.dataSource = self
        self.table.rowHeight = 80
        
        
        
        
    }
    
    
    /*func todaydate() -> String{
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd-yyyy"
        let result = formatter.string(from: date)
        //print(type(of: result))
        return result
        
    }*/
    
    var selectid: String = ""
    var selectname: String = ""
    var selectamount: Int = 0
    var selectdate: String = ""
    var selectcategory: String = ""
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        selectid = self.reminderdata[indexPath.row].id
        selectname = self.reminderdata[indexPath.row].name
        selectamount = self.reminderdata[indexPath.row].amount
        selectdate = self.reminderdata[indexPath.row].date
        selectcategory = self.reminderdata[indexPath.row].category
        self.performSegue(withIdentifier: "info_reminder", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "info_reminder" {
        
            let info = segue.destination as! ReminderInfo
            info.id_string = selectid
            info.name_string = selectname
            info.amount_int = selectamount
            info.date_string = selectdate
            info.cateory_string = selectcategory        }
        
        
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            self.reminderdata.remove(at: indexPath.row-1)
            let delete = self.reminderdata[indexPath.row-1]
            self.table.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
            deleteMethod(id: delete.id)
            
            
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.reminderdata.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "main_cell")! as! main_TableViewCell
       
        let name = self.reminderdata[indexPath.row].name
        let amount = self.reminderdata[indexPath.row].amount
        let date = self.reminderdata[indexPath.row].date
        let category = self.reminderdata[indexPath.row].category
        
        cell.name_label?.text = name
        cell.amount_label?.text = String(amount)
        cell.date_label?.text = date
        cell.category_label?.text = category
        
        return cell
    }
    
}
