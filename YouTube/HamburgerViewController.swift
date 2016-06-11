//
//  HamburgerViewController.swift
//  YouTube
//
//  Created by Moeed Mohammad on 6/10/16.
//  Copyright © 2016 Moeed Mohammad. All rights reserved.
//

import UIKit

class HamburgerViewController: UIViewController {
    
    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var feedView: UIView!
    
    var menuViewController: UIViewController!
    var feedViewController: UIViewController!
    var feedOriginalX: CGFloat!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Get the storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
          
        // Add the Feed View
        feedViewController = storyboard.instantiateViewControllerWithIdentifier("FeedViewController") as! FeedViewController
        addChildViewController(feedViewController)
        feedView.addSubview(feedViewController.view)
        feedViewController.didMoveToParentViewController(self)
        
        // Add the Menu View
        menuViewController = storyboard.instantiateViewControllerWithIdentifier("MenuViewController") as! MenuViewController
        menuView.addSubview(menuViewController.view)
        menuView.alpha = 0
        menuView.transform = CGAffineTransformMakeScale(0.8, 0.8)
        
    }
    @IBAction func didPan(sender: UIPanGestureRecognizer) {
        let translation = sender.translationInView(view)
        let velocity = sender.velocityInView(view)
    
        if sender.state == UIGestureRecognizerState.Began {
            feedOriginalX = feedView.center.x
        
        } else if sender.state == UIGestureRecognizerState.Changed {
            feedView.center.x = feedOriginalX + translation.x

            let scale = convertValue(feedView.frame.origin.x, r1Min: 0, r1Max: 275, r2Min: 0.9, r2Max: 1)
            let opacity = convertValue(feedView.frame.origin.x, r1Min: 0, r1Max: 275, r2Min: 0, r2Max: 1)
            menuView.transform = CGAffineTransformMakeScale(scale, scale)
            menuView.alpha = opacity
        
        } else if sender.state == UIGestureRecognizerState.Ended {
            
            // Opening Menu
            if velocity.x > 0 {
                UIView.animateWithDuration(0.4, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: [], animations: {
                    self.feedView.frame.origin.x = 275
                    self.menuView.transform = CGAffineTransformMakeScale(1, 1)
                    self.menuView.alpha = 1
                    }, completion: { (Bool) in
                        // code
                })
                
            // Closing Menu
            } else if velocity.x < 0 {
                UIView.animateWithDuration(0.4, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: [], animations: {
                    self.feedView.frame.origin.x = 0
                    }, completion: { (Bool) in
                        self.feedView.alpha = 1
                })
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
