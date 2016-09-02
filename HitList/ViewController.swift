//
//  ViewController.swift
//  HitList
//
//  Created by User on 9/1/16.
//  Copyright © 2016 Elijah Buters. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var people = [NSManagedObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        title = "\"The List\""
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - UITableView
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return people.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        let person = people[indexPath.row]
        cell!.textLabel!.text = person.value(forKey: "name") as? String
        
        return cell!
    }
    
    func saveName(_ name: String) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        
        let entity = NSEntityDescription.entity(forEntityName: "Person", in: managedContext)
        let person = NSManagedObject(entity: entity!, insertInto: managedContext)
        person.setValue(name, forKey: "name")
        
        do {
            try managedContext.save()
            people.append(person)
        } catch let error as NSError {
            print("Could not save \(error), \(error.userInfo)")
        }
    }

    // MARK: - Actions
    
    @IBAction func addName(_ sender: AnyObject) {
        
        let alert = UIAlertController(title: "Add name", message: "Add a new name", preferredStyle: .alert)
        let saveAction = UIAlertAction(title: "Save", style: .default, handler: { (action: UIAlertAction) -> Void in
            let textField = alert.textFields!.first
            self.names.append(textField!.text!)
            self.tableView.reloadData()
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .default) { (action: UIAlertAction) -> Void in
            }
            alert.addTextField(configurationHandler: { (textField: UITextField) -> Void in
                
                alert.addAction(saveAction)
                alert.addAction(cancelAction)
            
                self.present(alert, animated: true, completion: nil)
    })
    
    }
}

