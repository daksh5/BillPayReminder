//
//  edit_ViewController.swift
//  Bill Organizer
//
//  Created by Daksh Parikh on 4/8/20.
//  Copyright © 2020 Daksh Parikh. All rights reserved.
//

import UIKit

class edit_ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    @IBOutlet weak var name_edit: UITextField!
    
    @IBOutlet weak var amount_edit: UITextField!
    
    @IBOutlet weak var date_edit: UITextField!
    
    @IBOutlet weak var category_edit: UITextField!
    
    @IBOutlet weak var categorypicker: UIPickerView!
    
    private var datePicker: UIDatePicker?
    
    
    var id_string: String = ""
    var name_string: String = ""
    var amount_int: Int = 0
    var date_string: String = ""
    var cateory_string: String = ""
    
    var categorylist = ["Wifi","phone","water","creditcard","Electricity","Gas","subscription","Other"]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        name_edit.text? = name_string
        amount_edit.text? = String(amount_int)
        date_edit.text? = date_string
        category_edit.text? = cateory_string
        
        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .date
        datePicker?.addTarget(self, action: #selector(CreateReminderViewController.dateChanged(datePicker:)), for: .valueChanged)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(CreateReminderViewController.viewTapped(guestureRecognizer:)))
        
        view.addGestureRecognizer(tapGesture)
        
        date_edit.inputView = datePicker
    }
    
    @objc func viewTapped(guestureRecognizer: UITapGestureRecognizer){
           view.endEditing(true)
       }
       
       @objc func dateChanged(datePicker: UIDatePicker){
           let dateFormatter = DateFormatter()
           dateFormatter.dateFormat = "MM-dd-yyyy"
           date_edit.text = dateFormatter.string(from: datePicker.date)
           view.endEditing(true)
           
       }
    
    @IBAction func update_btn(_ sender: Any) {
        updatedb()
    }
    
    func updatedb(){
        
        let server = "http://localhost:8080/update/\(id_string)/\(name_edit.text!)/\(amount_edit.text!)/\(date_edit.text!)/\(category_edit.text!)"
        print(server)
                        
        
        guard let url  = URL(string: server) else {return}
            // background task to make request with URLSession
        let task = URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            if let error = error {
                print(error)
                return
            }
            guard let data = data else {return}
            guard let dataString = String(data: data, encoding: String.Encoding.utf8) else {return}
            // update the UI if all went OK
            DispatchQueue.main.async {
                
                print(dataString)
            }
        }
            
        task.resume()
        
    }
    
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categorylist.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {

        self.view.endEditing(true)
        return categorylist[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {

        self.category_edit.text = self.categorylist[row]
        self.categorypicker.isHidden = true
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {

        if textField == self.category_edit {
            self.categorypicker.isHidden = false
            //if you don't want the users to se the keyboard type:

            textField.endEditing(true)
        }
    }
    

}
