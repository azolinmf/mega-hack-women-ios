//
//  NewTaskViewController.swift
//  MegaHack
//
//  Created by Maria Fernanda Azolin on 04/09/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import UIKit

class NewTaskViewController: UIViewController, UIPopoverPresentationControllerDelegate, DataPickerDelegate, TaskPickerDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var dataButton: UIButton!
    @IBOutlet weak var taskTypeButton: UIButton!
    @IBOutlet weak var createButton: UIButton!
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var myPhoto: UIImageView!
    
    let calendar = Calendar.current
    var type = 0
    var date = Date()
    var dateWasChosen = false
    var typeWasChosen = false
    var name = ""
    
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
        createButton.isEnabled = false
        
        nameTextField?.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        profilePhotoUI()
        loadProfileImage()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        nameTextField.text = ""
        name = ""
        dataButton.setTitle("Data", for: .normal)
        taskTypeButton.setTitle("Tipo da tarefa", for: .normal)
    }
    
    func profilePhotoUI() {
        myPhoto.layer.borderWidth = 1
        myPhoto.layer.masksToBounds = false
        myPhoto.layer.borderColor = UIColor.white.cgColor
        myPhoto.layer.cornerRadius = myPhoto.frame.height/2
        myPhoto.clipsToBounds = true
    }
    
    func loadProfileImage() {
        let url = Profile.shared.photo
        downloadImage(from: url)
    }

    @IBAction func didPressTaskType(_ sender: Any) {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "taskPicker") as? TaskPickerViewController {
            vc.delegate = self
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    @IBAction func didPressDateButton(_ sender: Any) {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "data") as? DataPickerViewController {
            vc.delegate = self
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    func typeWasChosen(_ type: Int) {
        if type == 0 {
            taskTypeButton.setTitle("TAREFA DOMÉSTICA", for: .normal)
        } else if type == 1 {
            taskTypeButton.setTitle("COMPRAS", for: .normal)
        }
        
        self.type = type
        typeWasChosen = true
        enableCreate()
    }
    
    func dateWasChosen(_ date: Date) {
        dataButton.setTitle(formateDate(date: date), for: .normal)
        self.date = date
        dateWasChosen = true
        enableCreate()
    }
    
    func enableCreate() {
        guard let text = nameTextField.text else { return }
        if text.count >= 1 && typeWasChosen && dateWasChosen {
            createButton.isEnabled = true
        }
    }
    
    @IBAction func didPressCloseButton(_ sender: Any) {
        tabBarController?.selectedIndex = 0
    }
    
    @IBAction func didPressCreateButton(_ sender: Any) {
        name = nameTextField.text ?? ""
        let taskID = UUID().uuidString
        var owners = [Profile.shared.userID]
        //TODO: dar append dos outros owners da task
        let newTask = Task(title: name, type: type, date: calendar.component(.day, from: date), owners: owners)
        DAOFireBase.save(task: newTask)
        
        tabBarController?.selectedIndex = 0
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

extension NewTaskViewController {
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
            name = nameTextField.text ?? ""
        }
        enableCreate()
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
                self?.myPhoto.image = UIImage(data: data)
            }
        }
    }
}
