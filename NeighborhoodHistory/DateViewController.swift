//
//  DateViewController.swift
//  NeighborhoodHistory
//
//  Created by Kelly Mei on 8/7/21.
//

import UIKit

class DateViewController: UIViewController {

    let datePicker = UIDatePicker()
    
    @IBOutlet weak var dateText : UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(dateChange(datePicker:)), for: UIControl.Event.valueChanged)
        datePicker.frame.size = CGSize(width: 0, height: 300)
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.maximumDate = Date()
        
        dateText.inputView = datePicker
        dateText.text = formatDate(date: Date()) //today's date
        
        // creates the toolbar above date picker
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        // bar button
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([doneButton], animated: true)
        
        // assign toolbar
        dateText.inputAccessoryView = toolbar
        
        // assign date picker to the textfield
        dateText.inputView = datePicker
        
        }

    @ objc func donePressed() {
        dateText.text = "\(datePicker.date)"
        self.view.endEditing(true)
    }

    @objc func dateChange(datePicker: UIDatePicker){
        
        dateText.text = formatDate(date: datePicker.date)
    }

    // more readable date format
    func formatDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM dd yyyy"
        return formatter.string(from: date)
        }
        
    }
 
 
