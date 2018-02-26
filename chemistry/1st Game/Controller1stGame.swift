//
//  CardsViewController.swift
//  chemistry
//
//  Created by Louis Debaere on 02/02/2018.
//  Copyright © 2018 The Horcruxes. All rights reserved.
//

import UIKit
import AVFoundation

class Controller1stGame: UIViewController {
    var player: AVAudioPlayer?
    
    var elementsToGo = 0
    
    static var elementNameForNumber: [Int: String]!
    static var atomicWeightForNumber: [Int: String]!
    static var discoveryYearForNumber: [Int: String]!
    
    let backImage = UIImage(named: "Tile_Back")
    
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var iconSwitch: UISwitch!
    @IBOutlet weak var lathanidesActinidesStackView: UIStackView!
    @IBOutlet weak var tableStackView: UIStackView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var widthCollectionView: NSLayoutConstraint!
    @IBOutlet weak var heightCollectionView: NSLayoutConstraint!
    
    var cellSide: CGFloat {
        switch iPadModel {
        case "iPad":
            return 85
        case "iPad Pro 10.5":
            return 120
        default:
            return 140
        }
    }
    
    
    
    var level: [CardModel] = []
    var isFlipped = false
    var lastFlippedIndex = -1
    var lastFlippedCell: CardCell?
    
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
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        infoLabel.layer.borderWidth = 8
        infoLabel.layer.borderColor = UIColor.brown.cgColor
        
        collectionView.backgroundColor = .clear
        Controller1stGame.elementNameForNumber = setupElementNameForNumber()
        Controller1stGame.atomicWeightForNumber = setupAtomicWeightForNumber()
        Controller1stGame.discoveryYearForNumber = setupDiscoveryYearForNumber()
        
//        setupOriginalTable()
//        setupAdditionalTable()
        
        
        
        // Start the level
        createLevel(cardPairsCount: 9)
        
        widthCollectionView.constant = cellSide*6 + 20*5
        heightCollectionView.constant = cellSide*3 + 20*2
        
        
    }
    
    // Take the element name from the atomic number
    func setupElementNameForNumber() -> [Int: String] {
        
        var elementNameForNumber = [Int: String]()
        
        if let path = Bundle.main.path(forResource: "Elements", ofType: "plist") {
            let elements = NSArray(contentsOfFile: path)
            
            for element in elements! {
                let element = element as! [String: Any]
                let name = element["name"] as! String
                let number = element["atomicNumber"] as! Int
                elementNameForNumber[number] = name
            }
        } else {
            print("Elements.plist file not found")
        }
        
        return elementNameForNumber
    }
    
    // Take the element atomic weight from the atomic number
    func setupAtomicWeightForNumber() -> [Int: String] {
        
        var atomicWeightForNumber = [Int: String]()
        
        if let path = Bundle.main.path(forResource: "Elements", ofType: "plist") {
            let elements = NSArray(contentsOfFile: path)
            
            for element in elements! {
                let element = element as! [String: Any]
                let atomicWeight = element["atomicWeight"] as! String
                let number = element["atomicNumber"] as! Int
                atomicWeightForNumber[number] = atomicWeight
            }
        } else {
            print("Elements.plist file not found")
        }
        
        return atomicWeightForNumber
    }
    
    // Take the element discovery year from the atomic number
    func setupDiscoveryYearForNumber() -> [Int: String] {
        
        var discoveryYearForNumber = [Int: String]()
        
        if let path = Bundle.main.path(forResource: "Elements", ofType: "plist") {
            let elements = NSArray(contentsOfFile: path)
            
            for element in elements! {
                let element = element as! [String: Any]
                let discoveryYear = element["discoveryYear"] as! String
                let number = element["atomicNumber"] as! Int
                discoveryYearForNumber[number] = discoveryYear
            }
        } else {
            print("Elements.plist file not found")
        }
        
        return discoveryYearForNumber
    }
    
    
    func setupOriginalTable() {
        
        for view in tableStackView.arrangedSubviews {
            if let subStackView = view as? UIStackView {
                for view in subStackView.arrangedSubviews {
                    if let imageView = view as? UIImageView {
                        guard let name = Controller1stGame.elementNameForNumber[view.tag] else {
                            print("Invalid tag")
                            return
                        }
                        
                        imageView.image = UIImage(named: name)
                                                imageView.isHidden = true
                    } else {
                        for view in view.subviews {
                            if let imageView = view as? UIImageView {
                                guard let name = Controller1stGame.elementNameForNumber[view.tag] else {
                                    print("Invalid tag")
                                    return
                                }
                                
                                imageView.image = UIImage(named: name)
                                //                                imageView.isHidden = true
                            } else {
                                print("test2")
                            }
                        }
                    }
                }
            }
        }
    }
    
    func setupAdditionalTable() {
        for view in lathanidesActinidesStackView.arrangedSubviews {
            if let subStackView = view as? UIStackView {
                for view in subStackView.arrangedSubviews {
                    if let imageView = view as? UIImageView {
                        guard let name = Controller1stGame.elementNameForNumber[view.tag] else {
                            print("Invalid tag")
                            return
                        }
                                                
                        imageView.image = UIImage(named: name)
                    } else {
                        for view in view.subviews {
                            if let imageView = view as? UIImageView {
                                guard let name = Controller1stGame.elementNameForNumber[view.tag] else {
                                    print("Invalid tag")
                                    return
                                }
                                imageView.image = UIImage(named: name)
                            } else {
                                print("test2")
                            }
                        }
                    }
                }
            }
        }
    }
    
    func createRandomElementNumber() -> Int {
        return Int(arc4random_uniform(UInt32(Controller1stGame.elementNameForNumber!.count)) + 1)
    }
    
    func createLevel(cardPairsCount count: Int) {
        
//        self.iconSwitch.isEnabled = true
        
        var alreadyInThere = [Int]()
        
        var i = 1
        while i <= count {
            var randomElementNumber = createRandomElementNumber()
            while alreadyInThere.contains(randomElementNumber) {
                randomElementNumber = createRandomElementNumber()
            }
            alreadyInThere.append(randomElementNumber)
            print(randomElementNumber)
            let randomElementName = Controller1stGame.elementNameForNumber![randomElementNumber]!
            if let nameImage = UIImage(named: randomElementName), let symbolImage = UIImage(named: "\(randomElementName)2") {
                let nameCard = CardModel(element: randomElementNumber, image: nameImage)
                let symbolCard = CardModel(element: randomElementNumber, image: symbolImage)
                level.append(nameCard)
                level.append(symbolCard)
                i += 1
            } else {
                print("Images not found: \(randomElementName)")
            }
        }
//        for _ in 1...count {
//            let randomElementNumber = Int(arc4random_uniform(UInt32(Controller1stGame.elementNameForNumber!.count)))
//            print(randomElementNumber)
//            let randomElementName = Controller1stGame.elementNameForNumber![randomElementNumber]!
//            if let nameImage = UIImage(named: randomElementName), let symbolImage = UIImage(named: "\(randomElementName)2") {
//                let nameCard = CardModel(element: randomElementNumber, image: nameImage)
//                let symbolCard = CardModel(element: randomElementNumber, image: symbolImage)
//                level.append(nameCard)
//                level.append(symbolCard)
//            } else {
//                print("Images not found: \(randomElementName)")
//            }
//        }
        elementsToGo = count
        level.shuffle()
    }
    
    func cardSelected(cell: CardCell, index: IndexPath) {
        
        self.iconSwitch.isEnabled = false
        
        // - the function enter in this if statement only when the user already touched a cell becouse "isFlipped" is true. The beginning of the game is at the end of the function, in the last "else" statement when "isFlipped" is not true.
        
        if isFlipped {
            
            if lastFlippedIndex != index.row {
                
                let currentCard = level[index.row]
                let lastFlippedCard = level[lastFlippedIndex]
                
                self.view.isUserInteractionEnabled = false
                
                UIView.transition(with: cell, duration: 0.5, options: [.transitionFlipFromLeft], animations: {
                    cell.cardImage.image = currentCard.image
                }, completion: {(_) in
                    
                    
                    if currentCard.element == lastFlippedCard.element {
//                        matchingSound()
                        print("Elements MATCH")
                        // Highlight position in the table
                        var imagePath = ""
                        if self.iconSwitch.isOn {
                            imagePath = "2"
                        }
                        let elementImageView: UIImageView
                        if let imageView = self.tableStackView.viewWithTag(currentCard.element) {
                            elementImageView = imageView as! UIImageView
                            elementImageView.image = UIImage(named: Controller1stGame.elementNameForNumber[elementImageView.tag]! + imagePath)
                            self.updateInfoLabel(view: elementImageView)
                    
                        } else {
                            elementImageView = self.lathanidesActinidesStackView.viewWithTag(currentCard.element)! as! UIImageView
                            elementImageView.image = UIImage(named: Controller1stGame.elementNameForNumber[elementImageView.tag]! + imagePath)
                            self.updateInfoLabel(view: elementImageView)
                        }
                        
                        elementImageView.layer.isHidden = false
                        UIView.animate(withDuration: 2, animations: {
                            elementImageView.layer.zPosition = CGFloat(self.level.count / 2 - self.elementsToGo) + 1
                            elementImageView.transform = CGAffineTransform(scaleX: 5, y: 5)
                        })
                        UIView.animate(withDuration: 1, delay: 2, options: [], animations: {
                            elementImageView.transform = CGAffineTransform(scaleX: 1, y: 1)
                        }, completion: nil)
                        
                        self.isFlipped = false
                        self.elementsToGo -= 1
                        print("Elements to go: " + String(self.elementsToGo))
                        
                        if self.elementsToGo <= 0 {
//                            self.shuffleSound()
                            self.createLevel(cardPairsCount: 9)
                            for i in 0...15 {
                                self.collectionView.cellForItem(at: IndexPath(row: i, section: 0))?.isUserInteractionEnabled = true
                            }
                            self.collectionView.reloadData()
                            self.collectionView.reloadInputViews()
                            self.view.isUserInteractionEnabled = true
                            cell.isUserInteractionEnabled = true
                            self.lastFlippedCell?.isUserInteractionEnabled = true
                            return
                        }
                        
                        // - disable the cells: the first touched and the second one
                        cell.isUserInteractionEnabled = false
                        self.lastFlippedCell?.isUserInteractionEnabled = false
                        
                        // - make them disappear
                        UIView.animate(withDuration: 1, animations: {
                            cell.alpha = 0.0
                            self.lastFlippedCell?.alpha = 0.0
                        })
                        
                    } else {
                        print("Elements DO NOT MATCH")
                        self.isFlipped = false
                        UIView.transition(with: cell, duration: 0.5, options: [.transitionFlipFromLeft], animations: {
                            usleep(500_000)
                            cell.cardImage.image = self.backImage
                        })
                        UIView.transition(with: self.lastFlippedCell!, duration: 0.5, options: [.transitionFlipFromLeft], animations: {
                            self.lastFlippedCell!.cardImage.image = self.backImage
                        })
                    }
                    self.view.isUserInteractionEnabled = true
                })
                
            }
        }
            
            // - the game begins here, this else statement handles the first touch of the game
        else {
            lastFlippedIndex = index.row
            lastFlippedCell = cell
            isFlipped = true
            UIView.transition(with: cell, duration: 0.5, options: [.transitionFlipFromLeft], animations: {
                cell.cardImage.image = self.level[index.row].image
            })
        }
    }
    
    // Handles the flipping animation revealing the new image
    func flipCardCell(cell: CardCell, image: UIImage, completion: ((Bool) -> Void)? = nil) {
        UIView.transition(with: cell, duration: 0.5, options: [.transitionFlipFromLeft], animations: {
            cell.cardImage.image = image
        }, completion: completion)
    }
    
    // Show information of the elements you match
    func updateInfoLabel(view: UIImageView) {
        
        infoLabel.text?.removeAll()
        infoLabel.text?.append("Name: \(Controller1stGame.elementNameForNumber[view.tag]!)")
        infoLabel.text?.append("\nAtomic Number: \(view.tag)")
        infoLabel.text?.append("\nAtomic Weight: \(Controller1stGame.atomicWeightForNumber[view.tag]!)")
        infoLabel.text?.append("\nDiscovery Year: \(Controller1stGame.discoveryYearForNumber[view.tag]!)")
        
        // fading animation when labels update
        let transition = CATransition()
        transition.type = kCATransitionFade
        transition.duration = 0.4
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        infoLabel.layer.add(transition, forKey: nil)
    }
    
    
    // Sounds functions -- Uncomment when we find the sounds
//    func matchingSound() {
//        let sound = Bundle.main.url(forResource: <#T##String?#>, withExtension: <#T##String?#>)
//        do {
//            player = try AVAudioPlayer(contentsOf: sound!)
//            guard let player = player else {return}
//            player.prepareToPlay()
//            player.play()
//        } catch let error {
//            print(error.localizedDescription)
//        }
//    }
    
//    func shuffleSound() {
//        let sound = Bundle.main.url(forResource: "shuffle", withExtension: "mp3")
//        do {
//            player = try AVAudioPlayer(contentsOf: sound!)
//            guard let player = player else {return}
//            player.prepareToPlay()
//            player.play()
//        } catch let error {
//            print(error.localizedDescription)
//        }
//    }
}

extension Controller1stGame: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    // MARK: UICollectionViewDataSource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return level.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: cellSide, height: cellSide)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CardCell
        cell.cardImage.image = backImage
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! CardCell!
        cardSelected(cell: cell!, index: indexPath)
        
    }
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
}

extension Array {
    mutating func shuffle() {
        for _ in indices {
            sort { (_,_) in arc4random() < arc4random() }
        }
    }
}
