//
//  LabScene.swift
//  chemistry
//
//  Created by Louis Debaere on 20/02/2018.
//  Copyright © 2018 The Horcruxes. All rights reserved.
//

import SpriteKit

class LabScene: SKScene {
    
    var viewController: UIViewController!
    
    let game1Table = SKSpriteNode(imageNamed: "game1")
    let game2Table = SKSpriteNode(imageNamed: "game2")
    
    var game1ViewController: UIViewController!
    var game2ViewController: UIViewController!
    
    override func sceneDidLoad() {
        // Position the tables
        game1Table.position = CGPoint(x: 2000, y: 1000)
        game2Table.position = CGPoint(x: 900, y: 1200)
        // Put the tables in the scene
        scene?.addChild(game1Table)
        scene?.addChild(game2Table)
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        game1ViewController = storyboard.instantiateViewController(withIdentifier: "game1")
        game2ViewController = storyboard.instantiateViewController(withIdentifier: "game2")
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            if game1Table.contains(touch.location(in: self)) {
                viewController.present(game1ViewController, animated: true, completion: nil)
            } else if game2Table.contains(touch.location(in: self)) {
                viewController.present(game2ViewController, animated: true, completion: nil)
            }
        }
    }
}
