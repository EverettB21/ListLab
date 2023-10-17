//
//  CompletedTableTableViewController.swift
//  Lab - List
//
//  Created by Everett Brothers on 10/17/23.
//

import UIKit

class CompletedTableTableViewController: UITableViewController {

    var completedTasks: [ToDo]
    
    init?(coder: NSCoder, completedTasks: [ToDo]) {
        self.completedTasks = completedTasks
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) not implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "completeCell", for: indexPath)
        let task = completedTasks[indexPath.row]
        
        var content = cell.defaultContentConfiguration()
        content.text = task.title
        cell.contentConfiguration = content
        
        return cell
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return completedTasks.count
    }
}
