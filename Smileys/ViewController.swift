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

  override func viewDidLoad() {
    super.viewDidLoad()
    
    trayOpenPosition = tray.frame.origin
    trayClosedPosition = CGPoint(x: 0, y: view.frame.height - 30)
    
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }

    @IBAction func onTrayPanGesture(gesture: UIPanGestureRecognizer) {
        let point = gesture.locationInView(view)
        let translation = gesture.translationInView(view)
        
        if gesture.state == UIGestureRecognizerState.Began {
            trayOriginalCenter = tray.center
        } else if gesture.state == UIGestureRecognizerState.Changed {
            tray.center = CGPoint(x: (trayOriginalCenter?.x)!, y: (trayOriginalCenter?.y)! + translation.y)
        } else if gesture.state == UIGestureRecognizerState.Ended {
            let velocity = gesture.velocityInView(view)
          
          //Swiping down
          if velocity.y > 0 {
            UIView.animateWithDuration(0.4, animations: { () -> Void in
              self.tray.frame.origin = self.trayClosedPosition
            })
          }
          //Swiping up
          else {
//            UIView.animateWithDuration(0.5,
//              delay: 0,
//              usingSpringWithDamping: 0.7,
//              initialSpringVelocity: velocity.y / 2,
//              options: [],
//              animations: { () -> Void in
//                  self.tray.frame.origin = self.trayOpenPosition
//              }, completion: nil)

            UIView.animateWithDuration(0.4, animations: { () -> Void in
              self.tray.frame.origin = self.trayOpenPosition
            })
          }
        }
    }
}

