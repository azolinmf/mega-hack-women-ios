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
    
    var homeName = "Minha Casa"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initialUI()
        
        textFieldConfigs()
        
        profilePhotoUI()
        loadProfileImage()
        
    }
    
    func initialUI() {
        createButton.layer.cornerRadius = 25.0
        bottomContainer.layer.cornerRadius = 40.0
    }
    
    func textFieldConfigs() {
        nameTextField?.delegate = self
        addressTextField?.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
        self.view.addGestureRecognizer(tapGesture)
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
        checkHomeName()
        Profile.shared.homeName = homeName
        let homeID = UUID().uuidString
        let homeMembers = [Profile.shared.userID]
        let newHome = Home(homeID: homeID, users: homeMembers, name: homeName)
        let newAccount = Account(homeID: homeID, userID: Profile.shared.userID)
        
        DAOFireBase.save(home: newHome, account: newAccount)
        
        if let tabbar = (storyboard?.instantiateViewController(withIdentifier: "tabBar") as? UITabBarController) {
            tabbar.modalPresentationStyle = .fullScreen
            self.present(tabbar, animated: true, completion: nil)
        }
    }
    
    func checkHomeName() {
        if homeName == "" {
            homeName = "Minha casa"
        }
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
        if nameTextField != nil {
            homeName = nameTextField.text ?? "Minha Casa"
        }
        return false
    }
    
    @objc func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        nameTextField.resignFirstResponder()
        homeName = nameTextField.text ?? "Minha casa"
        addressTextField.resignFirstResponder()
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
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let textFieldText = textField.text,
            let rangeOfTextToReplace = Range(range, in: textFieldText) else {
                return false
        }
        let substringToReplace = textFieldText[rangeOfTextToReplace]
        let count = textFieldText.count - substringToReplace.count + string.count
        return count <= 30
    }
}


