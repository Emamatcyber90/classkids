//
//  CardModel.swift
//  chemistry
//
//  Created by Fabrizio Citro on 03/02/18.
//  Copyright © 2018 The Horcruxes. All rights reserved.
//

import Foundation
import UIKit

class CardModel {
    
    var element: String
    var image: UIImage
    let backImage: UIImage = #imageLiteral(resourceName: "back")
    
    
    init(element: String, image: UIImage) {
        self.element = element
        self.image = image
    }
    
}
