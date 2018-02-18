//
//  ViewController.swift
//  test
//
//  Created by Alessandro Falgiano on 14/02/18.
//  Copyright © 2018 Alessandro Falgiano. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var tapCounter = 0
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var outputLabel: UILabel!
    
    @IBOutlet weak var hint: UILabel!
    @IBOutlet weak var match: UIButton!
    @IBOutlet var buttons: [UIButton]!
    
    
    @IBAction func elementTap(_ sender: UIButton) {
        tapCounter += 1
        print("Number of Taps: \(tapCounter)")
        
        let buttonIndex = buttons.index(of: sender)!
        print("Button Index: \(buttonIndex)")
        updateLabel(currentButton: sender)
    }
    
    // calls the matching
    @IBAction func matching(_ sender: UIButton) {
        matchFormula()
    }
    
    // clear the outputLabel
    @IBAction func deleteTap(_ sender: UIButton) {
        outputLabel.text?.removeAll()
        
        // fading animation when labels update
        let transition = CATransition()
        transition.type = kCATransitionFade
        transition.duration = 0.3
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        view.layer.add(transition, forKey: nil)
    }
    
    
    // add the element's text in the outputLabel
    func updateLabel(currentButton: UIButton) {
        let buttonTitle = currentButton.title(for: .normal)!
        print("Element / Number: \(buttonTitle)")
        outputLabel.text?.append(buttonTitle)
//        matchFormula()
    }
//    func updateHint(currentButton: UIButton) {
//        let buttonTitle = currentButton.title(for: .normal)!
//        hint.text?.append(buttonTitle)
//    }
    
    // do the matching and build the alert (optional, we can find another way to show the user he succeded
    func matchFormula() {
        let valuesArray = Array(formulaDictionary.values)
        let keysArray = Array(formulaDictionary.keys)
        let successAlert = UIAlertController(title: "Amazeballs, si fott", message: nil, preferredStyle: .alert)
        let failAlert = UIAlertController(title: "Try again!", message: nil, preferredStyle: .alert)
        let successAction = UIAlertAction(title: "OK", style: .default, handler: {action in self.nextLevel()})
        let failAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        successAlert.addAction(successAction)
        failAlert.addAction(failAction)
        
        for i in valuesArray.indices {
            if outputLabel.text == valuesArray[i] {
                if targetLabel.text == keysArray[i] {
                    present(successAlert, animated: true, completion: nil)
                print("Match")
                }
            } else {
//                present(failAlert, animated: true, completion: nil)       I get an error here, don't know y
            }
        }
    }
    
    // display a new target and clear the user's inputs
    func nextLevel() {
        targetLabel.text = randomValue()
        outputLabel.text?.removeAll()
        
        // fading animation when labels update
        let transition = CATransition()
        transition.type = kCATransitionFade
        transition.duration = 0.3
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        view.layer.add(transition, forKey: nil)
    }
    
    override func viewDidLoad() {
        nextLevel()
        outputLabel.layer.borderWidth = 3
        outputLabel.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        hint.layer.borderWidth = 3
        hint.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        super.viewDidLoad()
    }

}
