//
//  LabViewController.swift
//  chemistry
//
//  Created by Fabrizio Citro on 19/02/2018.
//  Copyright © 2018 The Horcruxes. All rights reserved.
//

import UIKit
import SpriteKit

class LabViewController: UIViewController {
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = LabScene(fileNamed: "LabScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                // Setting self as the VC
                scene.viewController = self
                // Present the scene
                view.presentScene(scene)
            }
            view.ignoresSiblingOrder = false
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }
}
