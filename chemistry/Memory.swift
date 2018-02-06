//
//  Memory.swift
//  chemistry
//
//  Created by Louis Debaere on 05/02/2018.
//  Copyright © 2018 The Horcruxes. All rights reserved.
//

import Foundation

struct Memory {
    
    var numberOfFlips = 0
    var cards: [CardModel]!
    var level: [CardModel] = []
    
    init() {
        
        cards = DataManager.shared.makeCardsArray()
        
        for _ in 0...7 {
            let myIndex = cards.randomItem()
            level.append(cards[myIndex])
            level.append(cards[myIndex])
            cards.remove(at: myIndex)
        }
        level.shuffle()
        print(cards.count)
    }
    
    func matching() {
        
    }
}
