//
//  AddorRemove.swift
//  ListApp
//
//  Created by angryber.arc on 04/02/2018.
//  Copyright © 2018 angryber. All rights reserved.
//

import UIKit
import CoreData

//this is ui table view controller class, not default one
class AddorRemove: UITableViewController{

    //var userName = ["Marry", "Michael"]
    var userName=[NSManagedObject]()
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userName.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath) //indexPath
        //cell.textLabel?.text = userName[indexPath.row]
        let note = userName[indexPath.row]
        cell.textLabel?.text = note.value(forKey:"name") as? String
        // note.value(forKey:String), this is option value, so do type casting from option to string
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
                //self.userName.append(textField!.text!)
                //save functin on coreData
                self.saveName(textField!.text!)
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
    
    func saveName (_ name: String){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        //throught viewContext
        let managedContext = appDelegate.persistentContainer.viewContext
        //assign Note Entity to parameter
        let entity = NSEntityDescription.entity(forEntityName: "Note", in: managedContext)
        //caret a type of NSManagedObject for note
        let note = NSManagedObject(entity: entity!, insertInto: managedContext)
        //save value to Note.name (Entity.Attribute)
        note.setValue(name, forKey: "name")
        //real save to coreData storage
        //managedContext.save() this will throws error
        do{
            try managedContext.save()
            userName.append(note)
        }catch let error as NSError{
            print("Could not save: \(error), \(error.userInfo)")
            //or do nothing
        }
        
    }
    //grap stroge data when app view appears
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        //annnouce delegate and context
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        //fetch function, create request first for entity Name
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
        
        do{
            let results = try managedContext.fetch(fetchRequest) //this is array type
            userName = results as! [NSManagedObject]
        }catch let error as NSError{
            print("Cannot Fetch: \(error), \(error.userInfo)")
        }
        
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
            //start Back End
            //annnouce delegate and context
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let managedContext = appDelegate.persistentContainer.viewContext
            
            //only compare the core data and show data
            managedContext.delete(userName[indexPath.row])
            
            do{
                try managedContext.save()
            }catch let error as NSError{
                print("Could not Delete: \(error), \(error.userInfo)")
                //or do nothing
            }
            //handle with Front End
            userName.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
   

}
