//
//  colortuneDetailViewController.swift
//  Colortune
//
//  Created by Anna Torlen on 2/28/15.
//  Copyright (c) 2015 Anna Torlen. All rights reserved.
//

import UIKit

class colortuneDetailViewController: UIViewController {

    var pattern : Pattern? = nil
    var tappedImage : UIImage? = nil
    
    
    @IBOutlet var frontImageView: UIImageView!
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.title = self.pattern!.name
        self.frontImageView.image = UIImage(data: self.pattern!.frontImage)
        
        var frontTappedRecognizer = UITapGestureRecognizer(target: self, action: "frontTapped")
        self.frontImageView.addGestureRecognizer(frontTappedRecognizer)
    }

    func frontTapped() {
        self.tappedImage = self.frontImageView.image
        self.performSegueWithIdentifier("zoomSegue", sender: self)
        
    }
    
    

    @IBAction func backCancelButton(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "zoomSegue" {
            var zoomViewController = segue.destinationViewController as ZoomViewController
                    zoomViewController.image = self.tappedImage!

        }

        
        
        
    }
    

}
