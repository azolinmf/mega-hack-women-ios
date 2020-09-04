//
//  LoginViewController.swift
//  MegaHack
//
//  Created by Maria Fernanda Azolin on 03/09/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var subtitleLabel: UILabel!
        
    override func viewDidLoad() {
        super.viewDidLoad()

        labelUI()
    }

    func labelUI() {
        let boldText = "sobrecarregado"
        let fontBold = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.bold)
        let attrs = [NSAttributedString.Key.font : fontBold]
        let attributedString = NSMutableAttributedString(string:boldText, attributes:attrs)
        
        let normalText = "Se todos fizerem um pouquinho, ninguém fica "
        let normalString = NSMutableAttributedString(string:normalText)
        normalString.append(attributedString)
        
        subtitleLabel.attributedText = normalString
    }
    
}
