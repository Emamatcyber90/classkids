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
    
    @IBAction func matching(_ sender: UIButton) {
        matchFormula(textField: outputLabel)

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
    
    
    // add the element's text in the outputLabel and then calls the matching
    func updateLabel(currentButton: UIButton) {
        let buttonTitle = currentButton.title(for: .normal)!
        print("Element / Number: \(buttonTitle)")
        outputLabel.text?.append(buttonTitle)
//        matchFormula(textField: outputLabel)
    }
//    func updateHint(currentButton: UIButton) {
//        let buttonTitle = currentButton.title(for: .normal)!
//        hint.text?.append(buttonTitle)
//    }
    // do the matching and build the alert (optional, we can find another way to show the user he succeded
    func matchFormula(textField: UILabel) {
        let valuesArray = Array(formulaDictionary.values)
        let keysArray = Array(formulaDictionary.keys)
        let message = "Amazeballs, si fott"
        let alert = UIAlertController(title: message, message: nil, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: {action in self.nextLevel()})
        alert.addAction(okAction)
        
        for i in valuesArray.indices {
            if textField.text == valuesArray[i] {
                if targetLabel.text == keysArray[i] {
                    present(alert, animated: true, completion: nil)
                print("Match")
                }
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
