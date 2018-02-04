//
//  CardsViewController.swift
//  chemistry
//
//  Created by Louis Debaere on 02/02/2018.
//  Copyright © 2018 The Horcruxes. All rights reserved.
//

import UIKit

// Dummy data
let data = ["H": "Hhydrogen", "He": "Helium"]

private let reuseIdentifier = "Cell"

import UIKit

class CardsViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        levelCreator()
   
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
//    - levelCreator create the level with 8 random matches (16 cards) and remove them from the storage
    
    func levelCreator () {
        
        DataManager.shared.initialize()
        print(DataManager.shared.storage)
        print("------------------------")
        var level: [CardModel] = []
        
        for i in 0...7 {
            let myIndex = DataManager.shared.storage.randomItem()
            level.append(DataManager.shared.storage[myIndex])
            DataManager.shared.storage.remove(at: myIndex)
            print(level[i].element)
            print(level[i].image)
        }
    }
    
}

extension CardsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    // MARK: UICollectionViewDataSource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 4
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 250, bottom: 20, right: 0)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CardCell
        let card = DataManager.shared.helium
        
        cell.cardImage.image = card.backImage
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        
        UIView.transition(with: cell!, duration: 0.5, options: [.transitionFlipFromLeft], animations: {
            switch cell?.backgroundColor {
            case UIColor.blue?:
                cell?.backgroundColor = .green
            default:
                cell?.backgroundColor = .blue
            }
        }, completion: nil)
    }
    
    
}




//   - this function return a random item from the storage

extension Array {
    func randomItem() -> (Int) {
        let index = Int(arc4random_uniform(UInt32(self.count)))
        return index
    }
}


