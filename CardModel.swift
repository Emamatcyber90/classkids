//
//  CardModel.swift
//  chemistry
//
//  Created by Fabrizio Citro on 03/02/18.
//  Copyright © 2018 The Horcruxes. All rights reserved.
//

import UIKit

class CardModel {
    
    static let backImage = #imageLiteral(resourceName: "back")
    
    var isFlipped = false
    var isMatched = false
    var id: Int
    var image: UIImage
    
    
    init(id: Int, image: UIImage) {
        self.id = id
        self.image = image
    }
}

