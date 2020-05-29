//
//  CreateReminderViewController.swift
//  Bill Organizer
//
//  Created by Daksh Parikh on 2/18/20.
//  Copyright © 2020 Daksh Parikh. All rights reserved.
//

import UIKit

class CreateReminderViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    
    

    @IBOutlet weak var ReminderName: UITextField!
    
    @IBOutlet weak var ReminderAmount: UITextField!
    
    @IBOutlet weak var ReminderDate: UITextField!
    
    @IBOutlet weak var Category: UITextField!
    
    @IBOutlet weak var categorypicker: UIPickerView!
    
    private var datePicker: UIDatePicker?
    
    var categorylist = ["Wifi","phone","water","creditcard","Electricity","Gas","subscription","Other"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .dateAndTime
        datePicker?.addTarget(self, action: #selector(CreateReminderViewController.dateChanged(datePicker:)), for: .valueChanged)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(CreateReminderViewController.viewTapped(guestureRecognizer:)))
        
        view.addGestureRecognizer(tapGesture)
        
        ReminderDate.inputView = datePicker

    }
    
    @objc func viewTapped(guestureRecognizer: UITapGestureRecognizer){
        view.endEditing(true)
    }
    
    @objc func dateChanged(datePicker: UIDatePicker){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy"
        ReminderDate.text = dateFormatter.string(from: datePicker.date)
        view.endEditing(true)
        
    }
    
    
    func save_in_db(){
        
        let r_name = ReminderName.text!
        let r_amount = ReminderAmount.text!
        let r_date = ReminderDate.text!
        let r_category = Category.text!
    print("http://localhost:8080/save/\(r_name)/\(r_amount)/\(r_date)/\(r_category)")
            
        let server = "http://localhost:8080/save/\(r_name)/\(r_amount)/\(r_date)/\(r_category)"
            //let server = "http://localhost:8080/save/test/2/a/a"
            
        
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
            // start the task
            task.resume()
        
    }
    
    
    
    @IBAction func Createbtn(_ sender: Any) {
        save_in_db()
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

        self.Category.text = self.categorylist[row]
        self.categorypicker.isHidden = true
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {

        if textField == self.Category {
            self.categorypicker.isHidden = false
            //if you don't want the users to se the keyboard type:

            textField.endEditing(true)
        }
    }
    
}
