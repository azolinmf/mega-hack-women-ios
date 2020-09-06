//
//  DAOFirebase.swift
//  MegaHack
//
//  Created by Maria Fernanda Azolin on 06/09/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import Foundation
import Firebase

class DAOFireBase {
    
    static var instance = DAOFireBase()
    
    static func save(home: Home, account: Account) {
        
        let db = Firestore.firestore()
        
        var ref: DocumentReference? = nil
        
        let homeData: [String:Any] = home.mapToDictionary()
        ref = db.collection("home").addDocument(data: homeData) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
            }
        }
        
        let accountData: [String:Any] = account.mapToDictionary()
        ref = db.collection("accounts").addDocument(data: accountData) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
            }
        }
        
    }
    
    static func load(completion: @escaping ()->()) {
        
        let db = Firestore.firestore()
        
        db.collection("home").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                
                Model.instance.homes.removeAll()
                
                for document in querySnapshot!.documents {
                    let home = Home.mapToObject(homesData: document.data())
                    Model.instance.homes.append(home)
                }
                completion()
            }
        }
        
        db.collection("accounts").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                
                Model.instance.accounts.removeAll()
                
                for document in querySnapshot!.documents {
                    let account = Account.mapToObject(accountData: document.data())
                    Model.instance.accounts.append(account)
                }
                completion()
            }
        }
    }
    
}

