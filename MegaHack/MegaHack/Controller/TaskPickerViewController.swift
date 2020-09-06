//
//  TaskPickerViewController.swift
//  MegaHack
//
//  Created by Maria Fernanda Azolin on 04/09/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import UIKit

protocol TaskPickerDelegate: class {
    func typeWasChosen(_ type: Int)
}

class TaskPickerViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var taskTypePicker: UIPickerView!
    var pickerData: [String] = [String]()
    
    weak var delegate: TaskPickerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        containerView.layer.cornerRadius = 15.0
        
        pickerData = ["Tarefa Doméstica", "Compras"]
        taskTypePicker.delegate = self
        taskTypePicker.dataSource = self
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    @IBAction func didPressCloseButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func didPressOkButton(_ sender: Any) {
        let chosenType = taskTypePicker.selectedRow(inComponent: 0)
        delegate?.typeWasChosen(chosenType)
        
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
}
