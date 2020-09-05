//
//  TaskList.swift
//  MegaHack
//
//  Created by Maria Fernanda Azolin on 04/09/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import Foundation

class TaskList {
    
    static let shared = TaskList()
    
    private init() {
        
    }
    
    var tasks: [Task] = []
}
