//
//  Account.swift
//  MegaHack
//
//  Created by Maria Fernanda Azolin on 06/09/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import Foundation

class Account {
    
    internal init(homeID: String, userID: String) {
        self.homeID = homeID
        self.userID = userID
    }
    
    var homeID: String
    var userID: String
    
    func mapToDictionary() -> [String: Any] {
        var accountData: [String:Any] = [:]
        
        accountData["homeID"] = self.homeID
        accountData["userID"] = self.userID
        
        return accountData
    }
    
    static func mapToObject(accountData: [String: Any]) -> Account {
        
        let homeID:String = accountData["homeID"] as? String ?? ""
        let userID:String = accountData["userID"] as? String ?? ""

        let account = Account(homeID: homeID, userID: userID)
        
        return account
    }
}
