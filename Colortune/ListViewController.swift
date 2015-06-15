//
//  ListViewController.swift
//  Patterns
//
//  Created by Anna Torlen on 2/28/15.
//  Copyright (c) 2015 Anna Torlen. All rights reserved.
//

import Foundation
import UIKit

class ListViewController : UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet var tableView: UITableView!
    
    var topics = ["Play Colortune Tones", "Who was Wassily Kandinsky?"]
    
    var topic = "A"
    
    var cell = UITableViewCell()
    
    var image : UIImage = UIImage(named:"kandinsky.png")!
    //http://www.myinterestingfacts.com/wp-content/uploads/2014/05/Wassily-Kandinsky-Pic.jpg//
    
    
    override func viewDidLoad() {
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.topics.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        cell.backgroundColor = UIColor.whiteColor()
        cell.textLabel!.text = self.topics[indexPath.row]
        cell.imageView?.image = UIImage(named: "iconYes.png")
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.topic = self.topics[indexPath.row]
        self.performSegueWithIdentifier("topicDetailSegue", sender: self)
        cell.backgroundColor = UIColor.blueColor()
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var detailViewController = segue.destinationViewController as topicDetailViewController
        detailViewController.topic = self.topic
        
        
        
        if self.topic == "Play Colortune Tones" {
            detailViewController.topicDefinition = "Colorful Pitches and Instruments"
            
                        
        }
                if self.topic == "Who was Wassily Kandinsky?" {
            detailViewController.topicDefinition = "A Russian Artist (1866-1944)"
            detailViewController.image = self.image
        
        }
        
        
    }
    
    
}
