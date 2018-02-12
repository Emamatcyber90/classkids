//
//  DataManager.swift
//  chemistry
//
//  Created by Fabrizio Citro on 03/02/18.
//  Copyright © 2018 The Horcruxes. All rights reserved.
//

import Foundation
import UIKit

class DataManager {
    
    static let shared = DataManager()
    
    func makeElementArray() -> [CardModel] {
        var cards: [CardModel] = []
        if let path = Bundle.main.path(forResource: "Elements", ofType: "plist") {
            let elements = NSArray(contentsOfFile: path)
            for element in elements! {
                let element = element as! [String: Any]
                let name = element["name"] as! String
                if let nameImage = UIImage(named: name), let symbolImage = UIImage(named: "\(name)2") {
                    let nameCard = CardModel(element: name, image: nameImage)
                    let symbolCard = CardModel(element: name, image: symbolImage)
                    cards.append(nameCard)
                    cards.append(symbolCard)
                } else {
                    print("Images not found")
                }
            }
        } else {
            print("File not found")
        }
        
        return cards
    }
    
}
