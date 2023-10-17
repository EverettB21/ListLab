//
//  ViewController.swift
//  Lab - List
//
//  Created by Everett Brothers on 10/17/23.
//

import UIKit

class ViewController: UITableViewController, AddViewControllerDelegate {

    var tasks = [ToDo]()
    var cells: [IndexPath: UITableViewCell] = [:]
    var allTasks: [ToDo]!
    var completedTasks = [ToDo]()
    var edit = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        load()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTask))
    }
    
    @objc func addTask() {
        performSegue(withIdentifier: "toAdd", sender: nil)
    }
    
    @IBAction func viewCompleted(_ sender: Any) {
        if !completedTasks.isEmpty {
            performSegue(withIdentifier: "toCompleted", sender: nil)
        }
    }
    
    @IBAction func editCells() {
        for (index, cell) in cells {
            var task = tasks[index.row]
            if cell.accessoryType == .checkmark {
                task.isComplete = true
                completedTasks.insert(task, at: 0)
                tasks.remove(at: index.row)
                save()
                cells.removeValue(forKey: index)
                tableView.deleteRows(at: [index], with: .automatic)
            }
        }
    }

    @IBSegueAction func toDetail(_ coder: NSCoder) -> CompletedTableTableViewController? {
        return CompletedTableTableViewController(coder: coder, completedTasks: completedTasks)
    }
    
    func load() {
        allTasks = ToDo.loadFromFile()
        for task in allTasks {
            if task.isComplete {
                completedTasks.append(task)
            } else {
                tasks.append(task)
            }
        }
    }
    
    func save() {
        allTasks = tasks + completedTasks
        ToDo.saveToFile(tasks: allTasks)
    }
    
    @IBSegueAction func addSegue(_ coder: NSCoder) -> AddViewController? {
        let vc = AddViewController(coder: coder)
        vc?.delegate = self
        
        return vc
    }
    
    func recieve(_: AddViewController, newTask: ToDo) {
        tasks.insert(newTask, at: 0)
        save()
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let task = tasks[indexPath.row]
        
        var content = cell.defaultContentConfiguration()
        content.text = task.title
        cell.contentConfiguration = content
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        if let cell = cell {
            if cell.accessoryType == .checkmark {
                cell.accessoryType = .none
                cells.removeValue(forKey: indexPath)
            } else {
                cell.accessoryType = .checkmark
                cells[indexPath] = cell
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tasks.remove(at: indexPath.row)
            save()
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    @IBAction func unwindToTable(segue: UIStoryboardSegue) {
        
    }
}

