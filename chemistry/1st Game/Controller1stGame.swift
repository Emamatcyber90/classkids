//
//  CardsViewController.swift
//  chemistry
//
//  Created by Louis Debaere on 02/02/2018.
//  Copyright © 2018 The Horcruxes. All rights reserved.
//

import UIKit

class Controller1stGame: UIViewController {
    
    static var elementNameForNumber: [Int: String]!
    
    let backImage = UIImage(named: "Tile_Back")
    
    @IBOutlet weak var lathanidesActinidesStackView: UIStackView!
    @IBOutlet weak var tableStackView: UIStackView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var widthCollectionView: NSLayoutConstraint!
    @IBOutlet weak var heightCollectionView: NSLayoutConstraint!
    
    var cellSide: CGFloat = 85
    
    var level: [CardModel] = []
    var isFlipped = false
    var lastFlippedIndex = -1
    var lastFlippedCell: CardCell?
    var indexOfOnlyFacedUpCard: Int?
    var matches = 0
    
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
        
        collectionView.backgroundColor = .clear
        Controller1stGame.elementNameForNumber = setupElementNameForNumber()
        
        setupOriginalTable()
        setupAdditionalTable()
        
        switch iPadModel {
        case "iPad":
            cellSide = 85
        case "iPad Pro 10.5":
            cellSide = 120
        default:
            cellSide = 140
        }
        
        // Start the level
        createLevel(cardPairsCount: 7)
        
        widthCollectionView.constant = cellSide*6 + 20*5
        heightCollectionView.constant = cellSide*3 + 20*2
        
    }
    
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
//                                                imageView.isHidden = true
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
    
    func createLevel(cardPairsCount count: Int) {
        for _ in 0..<count {
            let randomElementNumber = Int(arc4random_uniform(UInt32(Controller1stGame.elementNameForNumber!.count)))
            let randomElementName = Controller1stGame.elementNameForNumber![randomElementNumber]!
            if let nameImage = UIImage(named: randomElementName), let symbolImage = UIImage(named: "\(randomElementName)2") {
                let nameCard = CardModel(element: randomElementNumber, image: nameImage)
                let symbolCard = CardModel(element: randomElementNumber, image: symbolImage)
                level.append(nameCard)
                level.append(symbolCard)
            } else {
                print("Images not found")
            }
        }
        level.shuffle()
    }
    
    func cardSelected(cell: CardCell, index: IndexPath) {
        
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
                        // Highlight position in the table
                        let elementImageView: UIView
                        if let imageView = self.tableStackView.viewWithTag(currentCard.element) {
                            elementImageView = imageView
                        } else {
                            elementImageView = self.lathanidesActinidesStackView.viewWithTag(currentCard.element)!
                        }
                        elementImageView.layer.isHidden = false
                        UIView.animate(withDuration: 2, animations: {
                            elementImageView.transform = CGAffineTransform(scaleX: 5, y: 5)
                        })
                        UIView.animate(withDuration: 1, delay: 2, options: [], animations: {
                            elementImageView.transform = CGAffineTransform(scaleX: 1, y: 1)
                        }, completion: nil)
                        
                        //                        UIView.animate(withDuration: 1, delay(1), animations: {
                        //                            elementImageView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
                        //                        })
                        print("Elements MATCH")
                        self.isFlipped = false
                        self.matches += 1
                        print(self.matches)
                        if self.matches == 7 {
                            self.createLevel(cardPairsCount: 10)
                            self.matches = 0
                            cell.isUserInteractionEnabled = true
                            for i in 0...15 {
                                self.collectionView.cellForItem(at: IndexPath(row: i, section: 0))?.isUserInteractionEnabled = true
                            }
                            self.collectionView.reloadData()
                            self.collectionView.reloadInputViews()
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
