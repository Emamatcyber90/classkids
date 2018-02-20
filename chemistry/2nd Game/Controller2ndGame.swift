//
//  ViewController.swift
//  test
//
//  Created by Alessandro Falgiano on 14/02/18.
//  Copyright © 2018 Alessandro Falgiano. All rights reserved.
//

import UIKit

class Controller2ndGame: UIViewController {
    
    
    static let elementsArray = ["H", "O", "Na", "C", "Ca", "S", "Cl", "Cu", "F", "I", "Zn", "Au", "Sn", "P", "Br", "Ti", "Mg", "Ag", "As", "N"]
    
    static let formulaDictionary = [ "Camphor": "C10H16O",  "Bromine": "Br2",  "Nitrate": "NO3−",  "Carbonic Acid": "H2CO3",  "Sodium Nitrate": "NaNO3",  "Aluminium foil": "Al2O3",  "Arsenic Trioxide": "As4O3",  "Magnesium Bromide": "MgBr2",  "Copper Sulfate": "CuSO4",  "Glucose": "C6H12O6",  "Sucrose": "C12H22O11",  "Carbon Monoxide": "CO",  "Baking Soda": "NaHCO3",  "Propane": "C3H8",  "Silver Oxide": "AgI",  "Sodium Hypochlorite": "NaClO",  "Oxygen": "O2",  "Carbon Dioxide": "CO2",  "Ammonium Sulfate": "(NH4)2SO4",  "Aspirin": "C9H8O4",  "Lactic Acid": "C3H6O3",  "Nitrogen": "N2O",  "Gold Trioxide": "Au2O3",  "Butane": "C4H10",  "Pentane": "C5H12",  "Benzene": "C6H6",  "Sodium Cyanide": "NaCN",  "Hydrogen Sulfide": "H2S",  "Octane": "C8H18",  "Hydrobromic Acid": "HBr",  "Ascorbic Acid": "C6H8O6",  "Ammonia": "NH3",  "Methane": "CH4",  "Zinc": "Zn(NO3)2",  "Calcium Oxide": "CaO",  "Fluoride": "F2",  "Caffeine": "C8H10N4O2",  "Sugar": "CnH2nOn",  "Sulfate": "O4S2-",  "Vinegar": "C2H4O2",  "Hydrochloric Acid": "HCl",  "Peroxide": "H2O2",  "Calcium Cyanide": "Ca(CN)2",  "Sulfuric Acid": "H2SO4",  "Acetone": "CH3COCH3",  "Sodium Hydroxide": "NaOH",  "Cholesterol": "C27H46O",  "Ethane": "C2H6",  "Water": "H2O",  "Alcohol": "C2H6O",  "Salt": "NaCl",  "Benzoic Acid": "C7H6O2",  "Sulfurous Acid": "H2SO3",  "Methanol": "CH3OH",  "Sulfate Group": "CaSO4",  "Phosphoric Acid": "H3PO4",  "Iodic Acid": "HIO3",  "Citric Acid": "C6H8O7"]

    
    var currentElementName: String! {
        didSet {
            targetLabel.text = currentElementName
            outputLabel.text?.removeAll()
            
            // fading animation when labels update
            let transition = CATransition()
            transition.type = kCATransitionFade
            transition.duration = 0.3
            transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
            view.layer.add(transition, forKey: nil)
        }
    }
    
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
                print("fail")

            }
        }

    }
    
    // display a new target and clear the user's inputs
    func nextLevel() {
        let elementCount = UInt32(Controller2ndGame.formulaDictionary.count)
        let randomIndex = Int(arc4random_uniform(elementCount))
        currentElementName = Array(Controller2ndGame.formulaDictionary.keys)[randomIndex]
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
