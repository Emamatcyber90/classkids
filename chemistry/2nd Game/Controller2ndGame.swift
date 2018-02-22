//
//  ViewController.swift
//  test
//
//  Created by Alessandro Falgiano on 14/02/18.
//  Copyright © 2018 Alessandro Falgiano. All rights reserved.
//

import UIKit

class Controller2ndGame: UIViewController {
    
    
    @IBOutlet weak var failingAnim: UIImageView!
    @IBOutlet weak var matchSucces: UIImageView!
    @IBOutlet weak var periodicTable: UIImageView!
    var touched = false
    
    let arr = ["exp1.png","exp2.png","exp3.png","exp4.png","exp5.png","exp6.png","exp7.png","exp8.png","exp9.png","exp10.png","exp11.png","exp12.png","exp13.png","exp14.png","exp15.png","exp16.png","exp17.png","exp18.png","exp19.png","exp20.png","exp21.png","exp22.png","exp23.png","exp24.png","exp25.png"]
    let arr2 = ["Bubbles0001.png","Bubbles0002.png","Bubbles0003.png","Bubbles0004.png","Bubbles0005.png","Bubbles0006.png","Bubbles0007.png","Bubbles0008.png","Bubbles0009.png","Bubbles0010.png","Bubbles0011.png","Bubbles0012.png","Bubbles0013.png","Bubbles0014.png","Bubbles0015.png","Bubbles0016.png","Bubbles0017.png","Bubbles0018.png","Bubbles0019.png","Bubbles0020.png","Bubbles0021.png","Bubbles0022.png","Bubbles0023.png","Bubbles0024.png","Bubbles0025.png","Bubbles0026.png","Bubbles0027.png","Bubbles0028.png","Bubbles0029.png","Bubbles0030.png","Bubbles0031.png","Bubbles0032.png","Bubbles0033.png","Bubbles0034.png","Bubbles0035.png","Bubbles0036.png","Bubbles0037.png","Bubbles0038.png","Bubbles0039.png","Bubbles0040.png","Bubbles0041.png","Bubbles0042.png","Bubbles0043.png","Bubbles0044.png","Bubbles0045.png","Bubbles0046.png","Bubbles0047.png","Bubbles0048.png","Bubbles0049.png","Bubbles0050.png","Bubbles0051.png"]
    
    static let elementsArray = ["H", "O", "Na", "C", "Ca", "S", "Cl", "Cu", "F", "I", "Zn", "Au", "Sn", "P", "Br", "Ti", "Mg", "Ag", "As", "N"]
    
    static let formulaDictionary = [ "Camphor": "C10H16O",  "Bromine": "Br2",  "Carbonic Acid": "H2CO3",  "Sodium Nitrate": "NaNO3",  "Aluminium foil": "Al2O3",  "Arsenic Trioxide": "As4O3",  "Magnesium Bromide": "MgBr2",  "Copper Sulfate": "CuSO4",  "Glucose": "C6H12O6",  "Sucrose": "C12H22O11",  "Carbon Monoxide": "CO",  "Baking Soda": "NaHCO3",  "Propane": "C3H8",  "Silver Oxide": "AgI",  "Sodium Hypochlorite": "NaClO",  "Oxygen": "O2",  "Carbon Dioxide": "CO2",  "Aspirin": "C9H8O4",  "Lactic Acid": "C3H6O3",  "Nitrogen": "N2O",  "Gold Trioxide": "Au2O3",  "Butane": "C4H10",  "Pentane": "C5H12",  "Benzene": "C6H6",  "Sodium Cyanide": "NaCN",  "Hydrogen Sulfide": "H2S",  "Octane": "C8H18",  "Hydrobromic Acid": "HBr",  "Ascorbic Acid": "C6H8O6",  "Ammonia": "NH3",  "Methane": "CH4",  "Zinc": "Zn(NO3)2",  "Calcium Oxide": "CaO",  "Fluoride": "F2",  "Caffeine": "C8H10N4O2",  "Sugar": "CnH2nOn", "Vinegar": "C2H4O2",  "Hydrochloric Acid": "HCl",  "Peroxide": "H2O2", "Sulfuric Acid": "H2SO4",  "Acetone": "CH3COCH3",  "Sodium Hydroxide": "NaOH",  "Cholesterol": "C27H46O",  "Ethane": "C2H6",  "Water": "H2O",  "Alcohol": "C2H6O",  "Salt": "NaCl",  "Benzoic Acid": "C7H6O2",  "Sulfurous Acid": "H2SO3",  "Methanol": "CH3OH",  "Sulfate Group": "CaSO4",  "Phosphoric Acid": "H3PO4",  "Iodic Acid": "HIO3",  "Citric Acid": "C6H8O7"]

    
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
    


    @IBOutlet weak var match: UIButton!
    @IBOutlet var buttons: [UIButton]!
    
    
    var flaconSize: CGFloat {
        switch iPadModel {
        case "iPad":
            return 85
        case "iPad Pro 10.5":
            return 120
        default:
            return 140
        }
    }
    
    
    var iPadModel: String {
        let height = UIScreen.main.bounds.height
        if height == 768 {
            return "iPad"
        } else if height == 834 {
            return "iPad Pro 10.5"
        } else {
            return "iPad Pro 12.9"
        }
    }
    
    
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
    
    @IBAction func skipLevel(_ sender: UIButton) {
        nextLevel()
    }
    
    
    @IBAction func showTable(_ sender: UIButton) {
        UIView.animate(withDuration: 0.5, animations: {
            self.periodicTable.isHidden = false
            self.periodicTable.transform = CGAffineTransform(scaleX: 10, y: 10)
            })
    }
    
    @IBAction func changeTable(_ sender: UITapGestureRecognizer) {
        if touched == false {
            periodicTable.image = UIImage(named: "Tab1")
            touched = true
        } else{
            periodicTable.image = UIImage(named: "Tab2")
            touched = false
        }
    }
    
    @IBAction func hideTable(_ sender: UITapGestureRecognizer) {
        UIView.animate(withDuration: 0.5, animations: {
            self.periodicTable.transform = CGAffineTransform(scaleX: 1, y: 1)
        } , completion: { (_) in
            self.periodicTable.isHidden = true
        })
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

//        let successAlert = UIAlertController(title: "Amazeballs, si fott", message: nil, preferredStyle: .alert)
//        let failAlert = UIAlertController(title: "Try again!", message: nil, preferredStyle: .alert)
//        let successAction = UIAlertAction(title: "OK", style: .default, handler: {action in self.nextLevel()})
//        let failAction = UIAlertAction(title: "OK", style: .default, handler: nil)
//        successAlert.addAction(successAction)
//        failAlert.addAction(failAction)
        
        if outputLabel.text! == Controller2ndGame.formulaDictionary[currentElementName!]! {
//            present(successAlert, animated: true, completion: nil)
            matchSucces.animationRepeatCount = 1
            matchSucces.startAnimating()
            nextLevel()
        } else {
//            present(failAlert, animated: true, completion: nil)
//            print("No Match")
            
            failingAnim.animationRepeatCount = 1
            failingAnim.startAnimating()
        }
        
    }
    
    // display a new target and clear the user's inputs
    func nextLevel() {
        let elementCount = UInt32(Controller2ndGame.formulaDictionary.count)
        let randomIndex = Int(arc4random_uniform(elementCount))
        currentElementName = Array(Controller2ndGame.formulaDictionary.keys)[randomIndex]
    }
    
    override func viewDidLoad() {
        print(arr2.count)
         var images1: [UIImage] = []
        var images2: [UIImage] = []
        
         for i in 0..<arr.count {
            images1.append(UIImage(named: arr[i])!)
        }
        failingAnim.animationImages = images1
        
        for i in 0..<arr2.count {
            images2.append(UIImage(named: arr2[i])!)
        }
        matchSucces.animationImages = images2

            
        nextLevel()
        outputLabel.layer.borderWidth = 3
        outputLabel.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        super.viewDidLoad()
        periodicTable.isHidden = true
    }
    
}


