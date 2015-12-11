//
//  ViewController.swift
//  CDSample
//
//  Created by Justin Davis on 12/10/15.
//  Copyright © 2015 Justin Davis. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var names: [Strings] = []
    
    @IBAction func addButton(sender: AnyObject) {
       let alert = UIAlertController(title: "Add String", message: "Add new String", preferredStyle: .Alert)
        let save = UIAlertAction(title: "Save", style: .Default) { (action: UIAlertAction) -> Void in
            let textField = alert.textFields![0] as UITextField
            self.saveString(textField.text!)
            self.tableView.reloadData()
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .Default) { (action: UIAlertAction) -> Void in
        }
        
        alert.addTextFieldWithConfigurationHandler { (textField: UITextField) -> Void in
        }
        
        alert.addAction(save)
        alert.addAction(cancel)
        
        presentViewController(alert, animated: true, completion: nil)
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let delegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context = delegate.managedObjectContext
        
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier:"Cell")
        title = "Basic String Storage"
        
        let request = NSFetchRequest(entityName: "Strings")
        
        var err: NSError?
        
        do {
            names = try context.executeFetchRequest(request) as! [Strings]
            
        }catch let err1 as NSError {
            err = err1
        }
        
        if err != nil{
            print("Unable to load data:")
            print(err)
            
        }

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func saveString(name: String){
        let delegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context = delegate.managedObjectContext
        
        let nameString = NSEntityDescription.insertNewObjectForEntityForName("Strings", inManagedObjectContext: context) as! Strings
        
        nameString.setValue(name, forKey: "stringName")
        
        var err: NSError?
        
        do {
            try context.save()
            self.names.append(nameString)
        }catch let err1 as NSError {
            err = err1
        }
        
        if err != nil{
            print("Unable to save data:")
            print(err)
            
        }

    }
    
    
    // Table view delegate methods
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath);
        cell.textLabel?.text = names[indexPath.row].stringName
        return cell
        
    }
    
    


}

