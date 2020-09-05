//
//  TipCell.swift
//  MegaHack
//
//  Created by Maria Fernanda Azolin on 05/09/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import UIKit

class TipCell: UITableViewCell {
    var tip: Tip? {
        didSet {
            guard let tip = tip else { return }
            self.title.text = tip.title
            self.descriptionText.text = tip.descriptionText
        }
    }
    
    func animate() {
        UIView.animate(withDuration: 0.5, delay: 0.3, usingSpringWithDamping: 0.8, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
            self.contentView.layoutIfNeeded()
        })
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

    }
    
    let title: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.text = "Titulo"
        label.numberOfLines = 0
        label.textColor = UIColor(displayP3Red: 47/255, green: 47/255, blue: 47/255, alpha: 1)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let descriptionText: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.text = "Uma descricao aqui"
        label.textColor = UIColor(displayP3Red: 188/255, green: 183/255, blue: 188/255, alpha: 1)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let chevronDown: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "chevron.down")
        image.tintColor = UIColor.MyTheme.darkGray
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    fileprivate let container: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.clipsToBounds = true
        v.backgroundColor = .white
        v.layer.cornerRadius = 8.0
        return v
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(container)
        
        container.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4).isActive = true
        container.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4).isActive = true
        container.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4).isActive = true
        container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4).isActive = true
        
        container.addSubview(title)
        container.addSubview(descriptionText)
        container.addSubview(chevronDown)
        
        title.topAnchor.constraint(equalTo: container.topAnchor).isActive = true
        title.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 16).isActive = true
        title.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -8).isActive = true
        title.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        descriptionText.topAnchor.constraint(equalTo: title.bottomAnchor).isActive = true
        descriptionText.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 16).isActive = true
        descriptionText.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -8).isActive = true
        descriptionText.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -4)
        
        chevronDown.centerYAnchor.constraint(equalTo: title.centerYAnchor).isActive = true
        chevronDown.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -12).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
