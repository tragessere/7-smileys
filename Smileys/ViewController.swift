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
    
    var faceOriginalCenter: CGPoint?
    
    @IBOutlet weak var arrow: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        trayOpenPosition = tray.frame.origin
        trayClosedPosition = CGPoint(x: 0, y: view.frame.height - 30)
    }
    
    @IBAction func onTrayPanGesture(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translationInView(view)
        
        if gesture.state == UIGestureRecognizerState.Began {
            trayOriginalCenter = tray.center
        } else if gesture.state == UIGestureRecognizerState.Changed {
            if tray.frame.origin.y < trayOpenPosition.y {
                tray.center = CGPoint(x: trayOriginalCenter!.x,
                    y: trayOriginalCenter!.y + translation.y/10)
            } else {
                tray.center = CGPoint(x: trayOriginalCenter!.x, y: trayOriginalCenter!.y + translation.y)
                arrow.transform = CGAffineTransformMakeRotation(((tray.frame.origin.y - trayOpenPosition.y) / (trayClosedPosition.y - trayOpenPosition.y)) * CGFloat(M_PI))
            }
        } else if gesture.state == UIGestureRecognizerState.Ended {
            let velocity = gesture.velocityInView(view)
            
            if velocity.y > 0 { //Swiping down
                UIView.animateWithDuration(0.5,
                    delay: 0,
                    usingSpringWithDamping: 0.7,
                    initialSpringVelocity: 10,
                    options: [],
                    animations: { () -> Void in
                        self.tray.frame.origin = self.trayClosedPosition
                    }, completion: nil)
            }
            else { //Swiping up
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
    
    var newFace: UIImageView!
    @IBAction func onDraggingFace(gesture: UIPanGestureRecognizer) {
        let imageView = gesture.view as! UIImageView

        if gesture.state == UIGestureRecognizerState.Began {
            newFace = UIImageView(image: imageView.image)
            view.addSubview(newFace)
            newFace.center = imageView.center
            newFace.center.y += tray.frame.origin.y
            faceOriginalCenter = newFace.center
            
        } else if gesture.state == UIGestureRecognizerState.Changed {
            let translation = gesture.translationInView(view)
            newFace.center = CGPoint(x: faceOriginalCenter!.x+translation.x, y: faceOriginalCenter!.y+translation.y)
        } else if gesture.state == UIGestureRecognizerState.Ended {
            if newFace.center.y >= tray.frame.origin.y {
                UIView.animateWithDuration(0.3, animations: { () -> Void in
                    self.newFace.alpha = 0
                    self.newFace.frame.size = CGSize(width: 120, height: 120)
                    self.newFace.frame.origin = CGPoint(x: self.newFace.frame.origin.x - 30, y: self.newFace.frame.origin.y - 30)
                    }, completion: { (whatever) -> Void in
                        self.newFace.removeFromSuperview()
                })
            }
            let panGesture = UIPanGestureRecognizer(target: self, action: "onMoving:")
            newFace.userInteractionEnabled = true
            newFace.addGestureRecognizer(panGesture)
            let pinchGesture = UIPinchGestureRecognizer(target: self, action: "onPinching:")
            newFace.addGestureRecognizer(pinchGesture)
            let rotateGesture = UIRotationGestureRecognizer(target: self, action: "onRotate:")
            newFace.addGestureRecognizer(rotateGesture)
            let doubleTapGesture = UITapGestureRecognizer(target: self, action: "onDoubleTap:")
            doubleTapGesture.numberOfTapsRequired = 2
            newFace.addGestureRecognizer(doubleTapGesture)
        }
    }
    
    func onMoving(gesture: UIPanGestureRecognizer) {
        let face = gesture.view
        face?.center = gesture.locationInView(view)
    }
    
    func onPinching(gesture: UIPinchGestureRecognizer) {
        let scale = gesture.scale
        let face = gesture.view!
        face.transform = CGAffineTransformMakeScale(scale, scale)
    }
    
    func onRotate(gesture: UIRotationGestureRecognizer) {
        let rotation = gesture.rotation
        let face = gesture.view!
        face.transform = CGAffineTransformMakeRotation(rotation)
    }
    
    func onDoubleTap(gesture: UITapGestureRecognizer) {
        let face = gesture.view!
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            face.alpha = 0
            face.frame.origin = CGPoint(x: face.frame.origin.x - face.frame.width/2, y: face.frame.origin.y - face.frame.height/2)
            face.frame.size = CGSize(width: 120, height: 120)
            }, completion: { (whatever) -> Void in
                face.removeFromSuperview()
        })
    }
}

