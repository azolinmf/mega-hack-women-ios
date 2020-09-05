//
//  Task.swift
//  MegaHack
//
//  Created by Maria Fernanda Azolin on 04/09/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import Foundation

class Task {
    internal init(title: String, type: TaskType, date: Int) {
        self.title = title
        self.type = type
        self.date = date
    }
    
    var title: String
    var type: TaskType
    var date: Int
}
