//
//  NewHomeViewController.swift
//  MegaHack
//
//  Created by Maria Fernanda Azolin on 05/09/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import UIKit

class NewHomeViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var myPhotoImage: UIImageView!
    @IBOutlet weak var addPersonButton: UIButton!
    @IBOutlet weak var createButton: UIButton!
    @IBOutlet weak var bottomContainer: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        createButton.layer.cornerRadius = 25.0
        bottomContainer.layer.cornerRadius = 40.0
        
        nameTextField?.delegate = self
        addressTextField?.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @IBAction func didPressAddPersonButton(_ sender: Any) {
    }
    
    @IBAction func didPressCreateButton(_ sender: Any) {
    }
    
}

extension NewHomeViewController {
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return false
    }
}
