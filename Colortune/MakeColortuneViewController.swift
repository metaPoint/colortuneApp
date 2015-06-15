//
//  MakeColortuneViewController.swift
//  Colortune
//
//  Created by Anna Torlen on 3/1/15.
//  Copyright (c) 2015 Anna Torlen. All rights reserved.
//

import UIKit
import CoreData

class MakeColortuneViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var frontPicture = true
    
    @IBOutlet var nameTextField: UITextField!
    
    @IBOutlet var frontImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        var frontTapRecognizer = UITapGestureRecognizer(target: self, action: "frontTapped")
        self.frontImageView.addGestureRecognizer(frontTapRecognizer)
        
        
}
        
    

    func frontTapped() {
        
        
        let fullRotation = CGFloat(M_PI * 2)
        let duration = 2.0
        let delay = 0.0
        let options = UIViewKeyframeAnimationOptions.CalculationModeLinear
        
        UIView.animateKeyframesWithDuration(duration, delay: delay, options: options, animations: {
            // each keyframe needs to be added here
            // within each keyframe the relativeStartTime and relativeDuration need to be values between 0.0 and 1.0
            
            UIView.addKeyframeWithRelativeStartTime(0, relativeDuration: 1/3, animations: {
                // start at 0.00s (5s × 0)
                // duration 1.67s (5s × 1/3)
                // end at   1.67s (0.00s + 1.67s)
                self.frontImageView.transform = CGAffineTransformMakeRotation(1/3 * fullRotation)
            })
            UIView.addKeyframeWithRelativeStartTime(1/3, relativeDuration: 1/3, animations: {
                self.frontImageView.transform = CGAffineTransformMakeRotation(2/3 * fullRotation)
            })
            UIView.addKeyframeWithRelativeStartTime(2/3, relativeDuration: 1/3, animations: {
                self.frontImageView.transform = CGAffineTransformMakeRotation(3/3 * fullRotation)
            })
            
            }, completion: {finished in
                self.frontPicture = true
                self.launchCamera()
                
        })
        
        
        
    }
    
    func launchCamera() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera){
            var cameraViewController = UIImagePickerController()
            cameraViewController.sourceType = UIImagePickerControllerSourceType.Camera
            cameraViewController.delegate = self
            self.presentViewController(cameraViewController, animated: true, completion: nil)
        }
        
    }
    
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        if self.frontPicture {
            self.frontImageView.image = image
            
        } else {
            
            //self.backImageView.image = image
        }
        picker.dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func cancelTapped(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }

    
    @IBAction func saveTapped(sender: AnyObject) {
//        var context = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext!
//        var pattern = NSEntityDescription.insertNewObjectForEntityForName("Pattern", inManagedObjectContext: context) as Pattern
//        pattern.name = self.nameTextField.text
//        pattern.frontImage = UIImageJPEGRepresentation(self.frontImageView.image, 1)
//        //pattern.backImage = UIImageJPEGRepresentation(self.backImageView.image, 1)
//        context.save(nil)
        self.dismissViewControllerAnimated(true, completion: nil)
        //self.presentViewController(ColorTuneViewController(), animated: true, completion: nil)
        self.performSegueWithIdentifier("savedSegue", sender: self)
        
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "savedSegue" {
            var context = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext!
            var pattern = NSEntityDescription.insertNewObjectForEntityForName("Pattern", inManagedObjectContext: context) as Pattern
            pattern.name = self.nameTextField.text
            pattern.frontImage = UIImageJPEGRepresentation(self.frontImageView.image, 1)
            //pattern.backImage = UIImageJPEGRepresentation(self.backImageView.image, 1)
            context.save(nil)
            //self.dismissViewControllerAnimated(true, completion: nil)
            //self.presentViewController(ColorTuneViewController(), animated: true, completion: nil)
            //self.performSegueWithIdentifier("savedSegue", sender: self)
        }



    }

    

}
