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

  override func viewDidLoad() {
    super.viewDidLoad()
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
            
        }
    }
}

