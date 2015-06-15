//
//  ColorTuneViewController.swift
//  Patterns
//
//  Created by Anna Torlen on 2/17/15.
//  Copyright (c) 2015 Anna Torlen. All rights reserved.
//

import UIKit
import CoreData

class ColorTuneViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    
    
   
    
    
    
    @IBOutlet var tableView: UITableView!
    
    var patterns : [Pattern] = []
    
    var selectedPattern : Pattern? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        //createTestPatterns()
        
        
    }
    
    
    override func viewWillAppear(animated: Bool) {
        var context = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext!
        
        var request = NSFetchRequest(entityName: "Pattern")
        
        var results = context.executeFetchRequest(request, error: nil)
        
        
        if results != nil {
            self.patterns = results! as [Pattern]
        }
    }
    
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.patterns.count
    }
    
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = UITableViewCell()
        var pattern = self.patterns[indexPath.row]
        cell.textLabel!.text = pattern.name
        cell.imageView?.image = UIImage(data: pattern.frontImage)
        return cell
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if(editingStyle == .Delete ) {
            let logItem = self.patterns[indexPath.row]
            var context = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext!
            context.deleteObject(logItem)
            //patterns.removeAtIndex(indexPath.row)
            viewWillAppear(true)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
            
            
        }
        
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.selectedPattern = self.patterns[indexPath.row]
        self.performSegueWithIdentifier("colortuneDetailSegue", sender: self)
        
    }
    
    @IBAction func cancelbackButton(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "colortuneDetailSegue" {
            var detailViewController = segue.destinationViewController as colortuneDetailViewController
            detailViewController.pattern = self.selectedPattern
        }
        
        
    }
    
    
    
    
    
    
    
    
    
}

