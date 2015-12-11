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
    
    var names: [String] = []
    
    @IBAction func addButton(sender: AnyObject) {
       let alert = UIAlertController(title: "Add String", message: "Add new String", preferredStyle: .Alert)
        let save = UIAlertAction(title: "Save", style: .Default) { (action: UIAlertAction) -> Void in
            let textField = alert.textFields![0] as UITextField
            self.names.append(textField.text!)
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
        
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier:"Cell")
        title = "Basic String Storage"
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        cell.textLabel?.text = names[indexPath.row]
        return cell
        
    }
    
    


}

