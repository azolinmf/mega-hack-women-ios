//
//  MenuViewController.swift
//  MegaHack
//
//  Created by Maria Fernanda Azolin on 06/09/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import UIKit

class MenuViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int){
        view.tintColor = UIColor.MyTheme.orange
    }
    
}
