//
//  Profile.swift
//  MegaHack
//
//  Created by Maria Fernanda Azolin on 06/09/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import UIKit

class Profile {
    
    static let shared = Profile()
    
    private init() {
        
    }
    
    var userID: String = ""
    var name: String = ""
    var photo: URL = URL(fileURLWithPath: "")
    
}
