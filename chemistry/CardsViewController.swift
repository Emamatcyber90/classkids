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

class CardsViewController: UIViewController {
    
    lazy var game = Memory()

    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var widthCollectionView: NSLayoutConstraint!
    @IBOutlet weak var heightCollectionView: NSLayoutConstraint!
    
    let cellSide: CGFloat = 100.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        levelCreator()
        
        widthCollectionView.constant = cellSide*4 + 20*3
        heightCollectionView.constant = cellSide*4 + 20*3
   
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
//    - levelCreator create the level with 8 random matches (16 cards) and remove them from the storage
    
    func levelCreator () {
        
        game = Memory()
        
    }
    
}



extension CardsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    // MARK: UICollectionViewDataSource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return game.level.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: cellSide, height: cellSide)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CardCell
        cell.cardImage.image = #imageLiteral(resourceName: "back")
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! CardCell!
        
        UIView.transition(with: cell!, duration: 0.5, options: [.transitionFlipFromLeft], animations: {
            switch cell?.cardImage.image {
            case #imageLiteral(resourceName: "back")?:
                cell?.cardImage.image = self.game.level[indexPath.row].image
            default:
                cell?.cardImage.image = #imageLiteral(resourceName: "back")
                
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

extension Array {
    mutating func shuffle() {
        for _ in indices {
            sort { (_,_) in arc4random() < arc4random() }
        }
    }
}


