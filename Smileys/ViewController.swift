//
//  ViewController.swift
//  Smileys
//
//  Created by Evan on 3/3/16.
//  Copyright © 2016 EvanTragesser. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tray: UIView!
    
    var trayOriginalCenter: CGPoint?
    var trayOpenPosition: CGPoint!
    var trayClosedPosition: CGPoint!
    var newFace: UIImageView?
    
    var faceOriginalCenter: CGPoint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        trayOpenPosition = tray.frame.origin
        trayClosedPosition = CGPoint(x: 0, y: view.frame.height - 30)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func onDraggingFace(gesture: UIPanGestureRecognizer) {
        let imageView = gesture.view as! UIImageView

        if gesture.state == UIGestureRecognizerState.Began {
            newFace = UIImageView(image: imageView.image)
            view.addSubview(newFace!)
            newFace?.center = imageView.center
            newFace?.center.y += tray.frame.origin.y
            faceOriginalCenter = newFace?.center
        } else if gesture.state == UIGestureRecognizerState.Changed {
            let translation = gesture.translationInView(view)
            newFace!.center = CGPoint(x: faceOriginalCenter!.x+translation.x, y: faceOriginalCenter!.y+translation.y)
        } else if gesture.state == UIGestureRecognizerState.Ended {
            if newFace!.center.y >= tray.frame.origin.y {
                UIView.animateWithDuration(0.3, animations: { () -> Void in
                    self.newFace?.alpha = 0
                    self.newFace?.frame.size = CGSize(width: 120, height: 120)
                    self.newFace?.frame.origin = CGPoint(x: self.newFace!.frame.origin.x - 30, y: self.newFace!.frame.origin.y - 30)
                    }, completion: { (whatever) -> Void in
                        self.newFace?.removeFromSuperview()
                })
            }
        }
    }
    
    
    @IBAction func onTrayPanGesture(gesture: UIPanGestureRecognizer) {
        //        let point = gesture.locationInView(view)
        let translation = gesture.translationInView(view)
        
        if gesture.state == UIGestureRecognizerState.Began {
            trayOriginalCenter = tray.center
        } else if gesture.state == UIGestureRecognizerState.Changed {
            tray.center = CGPoint(x: (trayOriginalCenter?.x)!, y: (trayOriginalCenter?.y)! + translation.y)
        } else if gesture.state == UIGestureRecognizerState.Ended {
            let velocity = gesture.velocityInView(view)
            
            //Swiping down
            if velocity.y > 0 {
              UIView.animateWithDuration(0.5,
                delay: 0,
                usingSpringWithDamping: 0.7,
                initialSpringVelocity: 10,
                options: [],
                animations: { () -> Void in
                  self.tray.frame.origin = self.trayClosedPosition
                }, completion: nil)
            }
            //Swiping up
            else {
                UIView.animateWithDuration(0.5,
                  delay: 0,
                  usingSpringWithDamping: 0.7,
                  initialSpringVelocity: 10,
                  options: [],
                  animations: { () -> Void in
                      self.tray.frame.origin = self.trayOpenPosition
                  }, completion: nil)

            }
        }
    }
}

