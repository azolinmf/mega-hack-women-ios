//
//  Home.swift
//  MegaHack
//
//  Created by Maria Fernanda Azolin on 05/09/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import Foundation

class Home {
    internal init(homeID: String, users: [String], name: String) {
        self.homeID = homeID
        self.users = users
        self.name = name
    }
    
    var homeID: String
    var users: [String]
    var name: String
    
}
