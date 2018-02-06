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
    var element: String
    var image: UIImage
    
    
    init(element: String, image: UIImage) {
        self.element = element
        self.image = image
    }
}

