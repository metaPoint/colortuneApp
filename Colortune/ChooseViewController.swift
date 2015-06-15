//
//  ChooseViewController.swift
//  Patterns
//
//  Created by Anna Torlen on 2/28/15.
//  Copyright (c) 2015 Anna Torlen. All rights reserved.
//

import Foundation
import UIKit


class ChooseViewController: UIViewController, UIScrollViewDelegate {
    
    
//    @IBOutlet var button: UIButton!
    
    var image: UIImage? = nil
    var tappedImage : UIImage? = nil
    
    
    @IBOutlet var imageView: UIImageView!
    
    
    @IBOutlet var bottomImageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //let duration = 1.0 // animation will take 1.0 seconds
        
        //UIView.animateWithDuration(duration, {
        // any changes entered in this block will be animated
        
        
        
        var frontTapRecognizer = UITapGestureRecognizer(target: self, action: "frontTapped")
        self.imageView.addGestureRecognizer(frontTapRecognizer)
        //self.bottomImageView.frame = CGRect(x: 320-50, y: 20, width: 50, height: 50)
        
        
//        var bottomTapRecognizer = UITapGestureRecognizer(target: self, action: "bottomTapped")
//        self.bottomImageView.addGestureRecognizer(bottomTapRecognizer)
//        //self.bottomImageView.frame = CGRect(x: 320-50, y: 120, width: 50, height: 50)
        
    
    }
    
//    @IBAction func circleTapped(sender:UIButton) {
//        self.navigationController?.popViewControllerAnimated(true)
//    }
    
    
    func frontTapped() {
        self.tappedImage = self.imageView.image
        
        let fullRotation = CGFloat(M_PI * 2)
        let duration = 2.0
        let delay = 0.0
        let options = UIViewKeyframeAnimationOptions.CalculationModeLinear
        let optionsT = UIViewAnimationOptions.Autoreverse
        
        
        UIView.animateKeyframesWithDuration(duration, delay: delay, options: options, animations: {
            // each keyframe needs to be added here
            // within each keyframe the relativeStartTime and relativeDuration need to be values between 0.0 and 1.0
            
            UIView.addKeyframeWithRelativeStartTime(0, relativeDuration: 1/3, animations: {
                // start at 0.00s (5s × 0)
                // duration 1.67s (5s × 1/3)
                // end at   1.67s (0.00s + 1.67s)
                self.imageView.transform = CGAffineTransformMakeScale(10, 10)
            })
            UIView.addKeyframeWithRelativeStartTime(1/3, relativeDuration: 1/3, animations: {
                self.imageView.transform = CGAffineTransformMakeScale(20, 20)
            })
            UIView.addKeyframeWithRelativeStartTime(2/3, relativeDuration: 1/3, animations: {
                self.imageView.transform = CGAffineTransformMakeScale(50, 50)
            })
//            UIView.addKeyframeWithRelativeStartTime(3/4, relativeDuration: 1/4, animations: {
//                self.imageView.transform = CGAffineTransformMakeScale(5.0, 5.0)
//            })
//            UIView.addKeyframeWithRelativeStartTime(4/4, relativeDuration: 1/4, animations: {
//                self.imageView.transform = CGAffineTransformMakeScale(1.0, 1.0)
//            })
            
            }, completion: {finished in
                self.performSegueWithIdentifier("makeTuneSegue", sender: self)
                
        })
        
        self.imageView.transform = CGAffineTransformMakeScale(1.0, 1.0)

        
    }
    
//    func bottomTapped() {
//        self.tappedImage = self.imageView.image
//        self.performSegueWithIdentifier("showListSegue", sender: self)
//        
//        
//            }
//    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
            if segue.identifier == "makeTuneSegue" {
            var learnViewController = segue.destinationViewController as MakeColortuneViewController
            
        }
//        if segue.identifier == "swipeSegue" {
//            var learnViewController = segue.destinationViewController as colortuneDetailViewController
//            
//        }

        
    }
    
    
    
    
}
