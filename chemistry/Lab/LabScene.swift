//
//  LabScene.swift
//  chemistry
//
//  Created by Louis Debaere on 20/02/2018.
//  Copyright © 2018 The Horcruxes. All rights reserved.
//

import Foundation

//@IBAction func handlePan(recognizer:UIPanGestureRecognizer) {
//    let translation = recognizer.translation(in: self.view)
//    if let view = recognizer.view {
//        view.center = CGPoint(x:view.center.x + translation.x,
//                              y:view.center.y + translation.y)
//    }
//    recognizer.setTranslation(CGPoint.zero, in: self.view)
//    if recognizer.state == UIGestureRecognizerState.ended {
//        
//        let velocity = recognizer.velocity(in: self.view)
//        let magnitude = sqrt((velocity.x * velocity.x) + (velocity.y * velocity.y))
//        let slideMultiplier = magnitude / 1000
//        print("magnitude: \(magnitude), slideMultiplier: \(slideMultiplier)")
//        
//        
//        let slideFactor = 0.1 * slideMultiplier     //Increase for more of a slide
//        
//        var finalPoint = CGPoint(x:recognizer.view!.center.x + (velocity.x * slideFactor),
//                                 y:recognizer.view!.center.y + (velocity.y * slideFactor))
//        
//        finalPoint.x = min(max(finalPoint.x, 0), self.view.bounds.size.width)
//        finalPoint.y = min(max(finalPoint.y, 0), self.view.bounds.size.height)
//        
//        
//        UIView.animate(withDuration: Double(slideFactor * 3),
//                       delay: 0, options: UIViewAnimationOptions.curveEaseOut, animations: {
//                        recognizer.view!.center = finalPoint },
//                       completion: nil)
//    }
//}
//
//@IBAction func touchChair(_ sender: UIButton) {
//    
//    if chairIsTouched == false {
//        UIView.animate(withDuration: 1, delay: 0.0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0.0, options: [], animations: {
//            self.chair6.bounds.size.width += 15.0
//            self.chair6.bounds.size.height += 15.0
//        }, completion: nil)
//        chairIsTouched = true
//    } else {
//        UIView.animate(withDuration: 1, delay: 0.0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0.0, options: [], animations: {
//            self.chair6.bounds.size.width -= 15.0
//            self.chair6.bounds.size.height -= 15.0
//        }, completion: nil)
//        chairIsTouched = false
//    }
//    
//}
//
//
//@IBAction func touchTheDoor(_ sender: UIButton) {
//    
//    if doorIsTouched == false {
//        shutter.alpha = 1
//        door.setImage(UIImage(named: "DoorOp"), for: UIControlState.normal)
//        doorIsTouched = true
//    } else{
//        shutter.alpha = 0
//        door.setImage(UIImage(named: "DoorCl"), for: UIControlState.normal)
//        doorIsTouched = false
//    }
//
//}

