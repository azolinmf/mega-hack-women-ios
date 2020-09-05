//
//  SupportViewController.swift
//  MegaHack
//
//  Created by Maria Fernanda Azolin on 05/09/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import UIKit

class SupportViewController: UIViewController {

    @IBOutlet weak var topContainer: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var homeLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var tableViewContainer: UIView!
    
    var sizes: [CGFloat] = []
    
    let tableView:UITableView = {
        let tb = UITableView()
        tb.translatesAutoresizingMaskIntoConstraints = false
        return tb
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        topContainer.layer.cornerRadius = 50.0
        topContainer.layer.maskedCorners = [.layerMaxXMaxYCorner]
        
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.minimumScaleFactor = 0.2
        
        subtitleLabel.adjustsFontSizeToFitWidth = true
        subtitleLabel.minimumScaleFactor = 0.2
        
        setUpTableView()
    }

    func setUpTableView() {
        tableViewContainer.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: tableViewContainer.topAnchor, constant: 15).isActive = true
        tableView.leadingAnchor.constraint(equalTo: tableViewContainer.leadingAnchor, constant: 32).isActive = true
        tableView.trailingAnchor.constraint(equalTo: tableViewContainer.trailingAnchor, constant: -32).isActive = true
        tableView.bottomAnchor.constraint(equalTo: tableViewContainer.bottomAnchor, constant: -5).isActive = true
        
        tableView.register(TipCell.self, forCellReuseIdentifier: "cell")
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
    }
    
    let tips = [
        Tip(title: "ROOOOOI", descriptionText: "Leticia ne"),
        Tip(title: "Largado as traças", descriptionText: "Henrique e Julioano joao neto e frederico etc etc"),
        Tip(title: "Travesseiro", descriptionText: "Tapete caixa lixo mesa celular cabo vidro copo, linhas, chao cozinha escada"),
        Tip(title: "Travesseiro", descriptionText: "Tapete caixa lixo mesa celular cabo vidro copo, linhas, chao cozinha escada linhas, chao cozinha escada linhas, chao cozinha escada linhas, chao cozinha escada linhas, chao cozinha escada linhas, chao cozinha escada linhas, chao cozinha escada linhas, chao cozinha escada linhas, chao cozinha escada linhas, chao cozinha escada linhas, chao cozinha escada v linhas, chao cozinha escada")
    ]
    
    var selectedIndex: IndexPath = IndexPath(row: -1, section: -1)
}

extension SupportViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tips.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if selectedIndex == indexPath {
            if sizes.count >= tips.count {
                return sizes[indexPath.row] + 100
            }
            return 200
        }
        
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TipCell
        
        cell.tip = tips[indexPath.row]
        cell.selectionStyle = .none
        cell.layer.cornerRadius = 8.0
        cell.backgroundColor = .clear
        
        cell.animate()
        
        sizes.append(cell.descriptionText.bounds.size.height)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath
        
        tableView.beginUpdates()
        tableView.reloadRows(at: [selectedIndex], with: .none)
        tableView.endUpdates()
    }
}


