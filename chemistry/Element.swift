//
//  File.swift
//  chemistry
//
//  Created by Fabrizio Citro on 06/02/18.
//  Copyright © 2018 The Horcruxes. All rights reserved.
//

import Foundation
import UIKit

class Element {
    
    var id: String
    var name: UIImage
    var symbol: UIImage
    
    
    init(id: String, name: UIImage , symbol: UIImage) {
        self.id = id
        self.name = name
        self.symbol = symbol
    }
}
