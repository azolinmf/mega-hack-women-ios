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
        
        profilePhotoUI()
        loadProfileImage()
    }
    
    func profilePhotoUI() {
        myPhotoImage.layer.borderWidth = 1
        myPhotoImage.layer.masksToBounds = false
        myPhotoImage.layer.borderColor = UIColor.white.cgColor
        myPhotoImage.layer.cornerRadius = myPhotoImage.frame.height/2
        myPhotoImage.clipsToBounds = true
    }
    
    func loadProfileImage() {
        let url = Profile.shared.photo
        downloadImage(from: url)
    }

    @IBAction func didPressAddPersonButton(_ sender: Any) {
    }
    
    @IBAction func didPressCreateButton(_ sender: Any) {
        let newHome = Home(homeID: <#T##String#>, users: <#T##[String]#>, name: <#T##String#>)
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
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func downloadImage(from url: URL) {
        print("Download Started")
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            DispatchQueue.main.async() { [weak self] in
                self?.myPhotoImage.image = UIImage(data: data)
            }
        }
    }
}


