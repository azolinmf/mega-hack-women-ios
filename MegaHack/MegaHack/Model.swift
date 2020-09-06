//
//  Model.swift
//  MegaHack
//
//  Created by Maria Fernanda Azolin on 06/09/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import UIKit

class Model {
    
    static let instance = Model()
    
    private init() {
        
    }
    
    var homes: [Home] = []
    var accounts: [Account] = []
    var tasks: [Task] = []
}
