//
//  DataPickerViewController.swift
//  MegaHack
//
//  Created by Maria Fernanda Azolin on 04/09/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import UIKit

protocol DataPickerDelegate: class {
    func dateWasChosen(_ flavor: Date)
}

class DataPickerViewController: UIViewController {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    weak var delegate: DataPickerDelegate?
    
    var sevenDaysfromNow: Date {
       return (Calendar.current as NSCalendar).date(byAdding: .day, value: 7, to: Date(), options: [])!
    }
    let currentDate = NSDate()  //get the current date
    
    override func viewDidLoad() {
        super.viewDidLoad()

        containerView.layer.cornerRadius = 15.0
        
        datePicker.minimumDate = currentDate as Date  //set the current date/time as a minimum
        datePicker.maximumDate = sevenDaysfromNow
    }

    @IBAction func didPressCloseButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func didPressOk(_ sender: Any) {
        let chosenDate = datePicker.date
        delegate?.dateWasChosen(chosenDate)
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    
}

