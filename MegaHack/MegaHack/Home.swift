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
    
    func mapToDictionary() -> [String: Any] {
        var homesData: [String:Any] = [:]
        
        homesData["homeID"] = self.homeID
        homesData["name"] = self.name
        homesData["users"] = self.users
        
        return homesData
    }
    
    static func mapToObject(homesData: [String: Any]) -> Home {
        
        let homeID:String = homesData["homeID"] as? String ?? ""
        let users:[String] = homesData["users"] as? [String] ?? []
        let name:String = homesData["name"] as? String ?? ""

        let home = Home(homeID: homeID, users: users, name: name)
        
        return home
    }
}
