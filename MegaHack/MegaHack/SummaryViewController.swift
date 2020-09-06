//
//  SummaryViewController.swift
//  MegaHack
//
//  Created by Maria Fernanda Azolin on 03/09/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import UIKit

class SummaryViewController: UIViewController {

    @IBOutlet weak var homeName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        homeName.text = Profile.shared.homeName
    }

}
