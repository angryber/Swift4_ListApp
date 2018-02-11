//
//  AddorRemove.swift
//  ListApp
//
//  Created by angryber.arc on 04/02/2018.
//  Copyright © 2018 angryber. All rights reserved.
//

import UIKit

//this is ui table view controller class, not default one
class AddorRemove: UITableViewController {

    var userName = ["Marry", "Michael"]
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userName.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath) //indexPath
        cell.textLabel?.text = userName[indexPath.row]
        return cell
    }

    @IBAction func addNewName(_ sender: Any) {
        
        let alert = UIAlertController(title:
            "Add New User", message: "type the name here", preferredStyle: .alert)
        
        let actionText = UIAlertAction(title: "Add", style: .default) { (AlertAction) in
            let textField = alert.textFields?.first //first textField
            //self.dis2.text = textField!.text
            let addWork = self.checkAdd(textField!.text!)
            if addWork{
                self.userName.append(textField!.text!)
                self.tableView.reloadData()
            }
        }
        
        let actionCancel = UIAlertAction(title: "Cancel", style: .default) { (AlertAction) in
            //do nothing
        }
        
        
        
        alert.addTextField { (textFieldb) in
            textFieldb.placeholder = "hahahah"
        }
        
        alert.addAction(actionText)
        alert.addAction(actionCancel)
        
        present(alert,animated: true, completion: nil)
        
    }
    func checkAdd (_ addName: String) -> Bool{
        var xyz = true
        if (addName == ""){
            xyz = false
            let alert = UIAlertController(title:
                "Error", message: "Cannot be Empty!!", preferredStyle: .alert)
            let actionCancel = UIAlertAction(title: "Cancel", style: .default) { (AlertAction) in
                //do nothing
            }
            alert.addAction(actionCancel) //pending to main notice
            
            present(alert,animated: true, completion: nil) //preset alert setup
            
        }
        return xyz
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            userName.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

}
