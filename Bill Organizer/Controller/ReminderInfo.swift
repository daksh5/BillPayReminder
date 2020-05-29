//
//  ReminderInfo.swift
//  Bill Organizer
//
//  Created by Daksh Parikh on 4/8/20.
//  Copyright © 2020 Daksh Parikh. All rights reserved.
//

import UIKit

class ReminderInfo: UIViewController {

    @IBOutlet weak var id_lable: UILabel!
    
    @IBOutlet weak var name_label: UILabel!
    
    @IBOutlet weak var amount_label: UILabel!
    
    @IBOutlet weak var date_label: UILabel!
    
    @IBOutlet weak var category_label: UILabel!
    
    
    
    
    var id_string: String = ""
    var name_string: String = ""
    var amount_int: Int = 0
    var date_string: String = ""
    var cateory_string: String = ""
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = name_string
        //id_lable.text? = id_string
        //name_label.text? = name_string
        amount_label.text? = String(amount_int)
        date_label.text? = date_string
        category_label.text? = cateory_string
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func edit_btn(_ sender: Any) {
        
        
        self.performSegue(withIdentifier: "viewtoedit", sender: self)
        
        //viewtoedit
        
        
        
    }
    
    @IBAction func delete_btn(_ sender: Any) {
        
        guard let url = URL(string: "http://localhost:8080/delete/\(id_string)") else {
            print("Error: cannot create URL")
            return
        }
        print("http://localhost:8080/delete/\(id_string)")
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        URLSession.shared.dataTask(with: request) { data, response, error in
            //print(response as Any)
            //print(data as Any)
            
        }.resume()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "viewtoedit" {
        
            let pass = segue.destination as! edit_ViewController
            pass.id_string = id_string
            pass.name_string = name_string
            pass.amount_int = amount_int
            pass.cateory_string = cateory_string
            pass.date_string = date_string
        }
        
        
    }
    

}
