//
//  ViewController.swift
//  test
//
//  Created by Alessandro Falgiano on 14/02/18.
//  Copyright © 2018 Alessandro Falgiano. All rights reserved.
//

import UIKit
import AVFoundation

class Controller2ndGame: UIViewController {
    var player: AVAudioPlayer?
    
    
    var currentLevel: Int = 1
    var hintTapped = false
    var matchesCounter: Int = 0
    var failsCounter: Int = 0
    var solution: String = ""
    @IBOutlet weak var elementsToGoLabel: UILabel!
    @IBOutlet weak var hintButton: UIButton!
    @IBOutlet weak var hintLabel: UILabel!
    @IBOutlet weak var failingAnim: UIImageView!
    @IBOutlet weak var matchSucces: UIImageView!
    @IBOutlet weak var periodicTable: UIImageView!
    @IBOutlet weak var levelLabel: UILabel!
    var touched = true
    
    var currentDictionary: [String : String] {
        switch currentLevel {
        case 1:
            return Controller2ndGame.formulaDictionary1Level
        default:
            return Controller2ndGame.formulaDictionary2Level
        }
    }
    
    var elementsToGo: Int {
        switch currentLevel {
        case 1:
            return 39
        default:
            return 18
        }

    }
    
    let explosionAnim = ["exp1.png","exp2.png","exp3.png","exp4.png","exp5.png","exp6.png","exp7.png","exp8.png","exp9.png","exp10.png","exp11.png","exp12.png","exp13.png","exp14.png","exp15.png","exp16.png","exp17.png","exp18.png","exp19.png","exp20.png","exp21.png","exp22.png","exp23.png","exp24.png","exp25.png"]
    let bubblesAnim = ["Bubbles0001.png","Bubbles0002.png","Bubbles0003.png","Bubbles0004.png","Bubbles0005.png","Bubbles0006.png","Bubbles0007.png","Bubbles0008.png","Bubbles0009.png","Bubbles0010.png","Bubbles0011.png","Bubbles0012.png","Bubbles0013.png","Bubbles0014.png","Bubbles0015.png","Bubbles0016.png","Bubbles0017.png","Bubbles0018.png","Bubbles0019.png","Bubbles0020.png","Bubbles0021.png","Bubbles0022.png","Bubbles0023.png","Bubbles0024.png","Bubbles0025.png","Bubbles0026.png","Bubbles0027.png","Bubbles0028.png","Bubbles0029.png","Bubbles0030.png","Bubbles0031.png","Bubbles0032.png","Bubbles0033.png","Bubbles0034.png","Bubbles0035.png","Bubbles0036.png","Bubbles0037.png","Bubbles0038.png","Bubbles0039.png","Bubbles0040.png","Bubbles0041.png","Bubbles0042.png","Bubbles0043.png","Bubbles0044.png","Bubbles0045.png","Bubbles0046.png","Bubbles0047.png","Bubbles0048.png","Bubbles0049.png","Bubbles0050.png","Bubbles0051.png"]
    
    static let elementsArray = ["H", "O", "Na", "C", "Ca", "S", "Cl", "Cu", "F", "I", "Zn", "Au", "Sn", "P", "Br", "Ti", "Mg", "Ag", "As", "N"]
    
    static var formulaDictionary1Level = ["Bromine": "Br2", "Carbonic Acid": "H2CO3", "Sodium Nitrate": "NaNO3", "Arsenic Trioxide": "As4O3", "Magnesium Bromide": "MgBr2",  "Copper Sulfate": "CuSO4", "Carbon Monoxide": "CO", "Propane": "C3H8", "Silver Oxide": "AgI", "Sodium Hypochlorite": "NaClO", "Oxygen": "O2", "Carbon Dioxide": "CO2", "Nitrous Oxide": "N2O", "Gold Trioxide": "Au2O3", "Butane": "C4H10", "Pentane": "C5H12", "Benzene": "C6H6", "Sodium Cyanide": "NaCN", "Hydrogen Sulfide": "H2S", "Octane": "C8H18", "Hydrobromic Acid": "HBr", "Ammonia": "NH3", "Methane": "CH4", "Calcium Oxide": "CaO", "Calcium Carbonate" : "CaCO3", "Fluoride": "F2", "Hydrochloric Acid": "HCl", "Hydrogen Peroxide": "H2O2", "Sulfuric Acid": "H2SO4", "Sodium Hydroxide": "NaOH", "Ethane": "C2H6", "Water": "H2O", "Alcohol": "C2H6O", "Salt": "NaCl", "Sulfurous Acid": "H2SO3", "Methanol": "CH3OH", "Sulfate Group": "CaSO4", "Phosphoric Acid": "H3PO4", "Iodic Acid": "HIO3"]

    static var formulaDictionary2Level = ["Camphor": "C10H16O", "Glucose": "C6H12O6", "Sucrose": "C12H22O11", "Aspirin": "C9H8O4", "Lactic Acid": "C3H6O3", "Caffeine": "C8H10N4O2", "Sugar": "CnH2nOn", "Vinegar": "C2H4O2", "Acetone": "CH3COCH3", "Cholesterol": "C27H46O", "Citric Acid": "C6H8O7", "Magnesium Sulfate" : "MgSO47H2O", "Chloroform" :"CHCl3", "Ascorbic Acid": "C6H8O6", "Trinitrotoluene" : "C7H5N3O6", "Baking Soda": "NaHCO3", "Benzoic Acid": "C7H6O2", "Ammonium Chloride" : "NH4Cl"]
    
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
        let buttonTitle = sender.title(for: .normal)!
        print("Element / Number: \(buttonTitle)")
        outputLabel.text?.append(buttonTitle)
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
            self.periodicTable.transform = CGAffineTransform(scaleX: 8, y: 8)
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
    
    
    // do the matching and the animations
    func matchFormula() {
        
        if outputLabel.text! == currentDictionary[currentElementName!]! {
            bubbleSound()
            matchSucces.animationDuration = 1
            matchSucces.animationRepeatCount = 1
            matchSucces.startAnimating()
            matchesCounter += 1
            print("Matches: \(matchesCounter)")
            
            if currentLevel == 1 {
                Controller2ndGame.formulaDictionary1Level.removeValue(forKey: currentElementName)
            } else if currentLevel == 2 {
                Controller2ndGame.formulaDictionary2Level.removeValue(forKey: currentElementName)
            }
            
            if matchesCounter == elementsToGo {
                currentLevel += 1
                targetLabel.textColor = UIColor.blue
                levelLabel.text = "Level 2"
                levelLabel.textColor = UIColor.blue
                let transition = CATransition()
                transition.type = kCATransitionFade
                transition.duration = 0.3
                transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
                levelLabel.layer.add(transition, forKey: nil)
            }
            nextLevel()
        } else {
            explosionSound()
            failingAnim.animationRepeatCount = 1
            failingAnim.startAnimating()
            failsCounter += 1
            print("Fail number \(failsCounter)")
            if failsCounter == 3 {
                hintButton.isHidden = false
                let transition = CATransition()
                transition.type = kCATransitionFade
                transition.duration = 0.3
                transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
                hintButton.layer.add(transition, forKey: nil)
            }
        }
    }
    
    // display a new target and clear the user's inputs
    func nextLevel() {
        failsCounter = 0
        hintLabel.isHidden = true
        hintButton.isHidden = true
        
        hintButton.isUserInteractionEnabled = true
        hintButton.alpha = 1
        
        let elementCount = UInt32(currentDictionary.count)
        let randomIndex = Int(arc4random_uniform(elementCount))
        currentElementName = Array(currentDictionary.keys)[randomIndex]
        solution = Array(currentDictionary.values)[randomIndex]
        
        print("Solution: \(solution)")
    }
    
    // ADD SOUNDS
    func bubbleSound() {
        let sound = Bundle.main.url(forResource: "Bubbles", withExtension: "mp3")
        do {
            player = try AVAudioPlayer(contentsOf: sound!)
            guard let player = player else {return}
            player.prepareToPlay()
            player.play()
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    
    func explosionSound() {
        let sound = Bundle.main.url(forResource: "explosion", withExtension: "mp3")
        do {
            player = try AVAudioPlayer(contentsOf: sound!)
            guard let player = player else {return}
            player.prepareToPlay()
            player.play()
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    @IBAction func tapHint(_ sender: UIButton) {
        hintTapped = true
        hintLabel.text = "Shuffled Formula: "
        var solutionArray = Array(solution)
        solutionArray.shuffleSolution()
        let shuffledSolution = String(solutionArray)
        hintLabel.isHidden = false
        hintLabel.text?.append(shuffledSolution)
        
        if hintTapped {
            hintButton.isUserInteractionEnabled = false
            hintButton.alpha = 0.5
        }
    }
    
    
    override func viewDidLoad() {
        nextLevel()
        
        hintLabel.backgroundColor = UIColor.white
        hintLabel.layer.borderWidth = 1.5
        hintLabel.layer.borderColor = UIColor.black.cgColor
        hintLabel.layer.masksToBounds = true
        hintLabel.layer.cornerRadius = 8
        
        elementsToGoLabel.text = ""
        
        var images1: [UIImage] = []
        var images2: [UIImage] = []
        
         for i in 0..<explosionAnim.count {
            images1.append(UIImage(named: explosionAnim[i])!)
        }
        failingAnim.animationImages = images1
        
        for i in 0..<bubblesAnim.count {
            images2.append(UIImage(named: bubblesAnim[i])!)
        }
        matchSucces.animationImages = images2
        
        outputLabel.layer.borderWidth = 3
        outputLabel.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        super.viewDidLoad()
        periodicTable.isHidden = true
    }
}


extension Array {
    mutating func shuffleSolution() {
        for i in 0..<(count - 1) {
            let j = Int(arc4random_uniform(UInt32(count - i))) + i
            guard i != j else { continue}
            self.swapAt(i, j)
        }
    }
}


