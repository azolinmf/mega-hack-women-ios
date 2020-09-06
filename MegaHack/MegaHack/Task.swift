//
//  Task.swift
//  MegaHack
//
//  Created by Maria Fernanda Azolin on 04/09/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import Foundation

class Task {
    internal init(title: String, type: Int, date: Int, owners: [String]) {
        self.title = title
        self.type = type
        self.date = date
        self.owners = owners
    }
    
    var title: String
    var type: Int
    var date: Int
    var owners: [String]
    
    func mapToDictionary() -> [String: Any] {
        var taskData: [String:Any] = [:]
        
        taskData["title"] = self.title
        taskData["type"] = self.type
        taskData["date"] = self.date
        taskData["owners"] = self.owners
        
        return taskData
    }
    
    static func mapToObject(tasksData: [String: Any]) -> Task {
        
        let title:String = tasksData["title"] as? String ?? ""
        let owners:[String] = tasksData["owners"] as? [String] ?? []
        let type:Int = tasksData["type"] as? Int ?? 0
        let date:Int = tasksData["date"] as? Int ?? 1

        let task = Task(title: title, type: type, date: date, owners: owners)
        
        return task
    }
}
