//
//  TasksViewController.swift
//  MegaHack
//
//  Created by Maria Fernanda Azolin on 03/09/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import UIKit

enum taskType: String {
    case domestic = "TAREFA DOMÉSTICA"
    case shopping = "COMPRAS"
}

extension UIColor {
  struct MyTheme {
    static var orange: UIColor  { return UIColor(red: 243/255, green: 174/255, blue: 89/255, alpha: 1) }
    static var darkGray: UIColor { return UIColor(red: 210/255, green: 206/255, blue: 204/255, alpha: 1) }
    static var lightGray: UIColor { return UIColor(red: 254/255, green: 250/255, blue: 246/255, alpha: 1) }
    static var green: UIColor { return UIColor(red: 60/255, green: 181/255, blue: 165/255, alpha: 1) }
  }
}

class TasksViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var newTaskButton: UIButton!
    @IBOutlet weak var daysCollectionView: UICollectionView!
    @IBOutlet weak var tasksTableView: UITableView!
    
    let date = Date()
    let calendar = Calendar.current
    var selectedIndex = 0
    var selectedDay = 0
    var tasks: [Task] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        topView.layer.cornerRadius = 30.0
        newTaskButton.layer.cornerRadius = 18.0
        
        daysCollectionView.delegate = self
        daysCollectionView.dataSource = self
        tasksTableView.delegate = self
        tasksTableView.dataSource = self
        
        let today = calendar.component(.day, from: date)
        let newTask = Task(title: "Varrer a cozinha", type: .domestic, date: today)
        tasks.append(newTask)
        let newTask2 = Task(title: "Varrer a cozinhaaaa", type: .domestic, date: today)
        tasks.append(newTask2)
        let tomorrow = calendar.component(.day, from: date) + 1
        let newTask3 = Task(title: "VARRER tudo", type: .shopping, date: tomorrow)
        tasks.append(newTask3)
        let newTask4 = Task(title: "Tem que varrer né", type: .domestic, date: today)
        tasks.append(newTask4)
        
        selectedDay = today
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    func intToDay(day: Int) -> String {
        switch day {
        case 7:
            return "Sábado"
        case 8:
            return "Domingo"
        case 9:
            return "Segunda"
        case 10:
            return "Terça"
        case 11:
            return "Quarta"
        case 5:
            return "Quinta"
        case 6:
            return "Sexta"
        default:
            return "Segunda"
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "daysCell", for: indexPath) as! DaysCell
        
        cell.layer.cornerRadius = 5.0
        
        var day = calendar.component(.day, from: date)
        day += indexPath.row
        cell.number.text = String(day)
        
        if indexPath.row > 0 {
            var weekDay = calendar.component(.weekday, from: date)
            weekDay += indexPath.row
            cell.text.text = intToDay(day: weekDay)
        } else {
            cell.text.text = "Hoje"
        }
        
        if selectedIndex == indexPath.item {
            cell.backgroundColor = UIColor.MyTheme.orange
            cell.number.textColor = UIColor.white
            cell.text.textColor = UIColor.white
        } else {
            cell.backgroundColor = UIColor.MyTheme.lightGray
            cell.number.textColor = UIColor.black
            cell.text.textColor = UIColor.darkGray
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 68, height: 68)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! DaysCell

        if let text = cell.number.text, let value = Int(text) {
            selectedDay = value
        }
        
        selectedIndex = indexPath.item
        daysCollectionView.reloadData()
        tasksTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) as! TaskTableViewCell
        
        cell.isHidden = true
        cell.layer.cornerRadius = 8.0
        cell.containerView.layer.cornerRadius = 8.0
        
        let task = tasks[indexPath.row]
        
        cell.titleLabel.text = task.title
        cell.typeLabel.text = task.type.rawValue
        
        if selectedDay == task.date {
            cell.isHidden = false
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tasks[indexPath.row].date == selectedDay {
            return 75
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tasksTableView.cellForRow(at: indexPath) as! TaskTableViewCell
        
        cell.doneImage.image = UIImage(systemName: "checkmark.circle.fill")
        cell.doneImage.tintColor = UIColor.MyTheme.green
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
}
