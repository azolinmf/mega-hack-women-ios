//
//  NewTaskViewController.swift
//  MegaHack
//
//  Created by Maria Fernanda Azolin on 04/09/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import UIKit

class NewTaskViewController: UIViewController, UIPopoverPresentationControllerDelegate, DataPickerDelegate {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var dataButton: UIButton!
    @IBOutlet weak var taskTypeButton: UIButton!
    @IBOutlet weak var createButton: UIButton!
    
    let calendar = Calendar.current
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tabBarController?.tabBar.isHidden = true
        containerView.layer.cornerRadius = 40.0
        
        dataButton.layer.cornerRadius = 5.0
        dataButton.layer.borderColor = UIColor.MyTheme.darkGray.cgColor
        dataButton.layer.borderWidth = 1
        dataButton.contentHorizontalAlignment = .left
        
        taskTypeButton.layer.cornerRadius = 5.0
        taskTypeButton.layer.borderColor = UIColor.MyTheme.darkGray.cgColor
        taskTypeButton.layer.borderWidth = 1
        taskTypeButton.contentHorizontalAlignment = .left
        
        createButton.layer.cornerRadius = 18.0
    }

    @IBAction func didPressTaskType(_ sender: Any) {
    }
    
    @IBAction func didPressDateButton(_ sender: Any) {
        
        if let vc = storyboard?.instantiateViewController(withIdentifier: "data") as? DataPickerViewController {
          
            vc.delegate = self
            self.navigationController?.pushViewController(vc, animated: true)
        }

    }
    
    func dateWasChosen(_ date: Date) {
        dataButton.setTitle(formateDate(date: date), for: .normal)
    }
    
    func formateDate(date: Date) -> String {
        let day = calendar.component(.day, from: date)
        let month = calendar.component(.month, from: date)
        var formated = ""
        
        if day <= 9 {
            formated = "0"
        }
        formated += String(day) + "/"
        
        if month <= 9 {
            formated += "0"
        }
        formated += String(month)
        
        return formated
    }
}
