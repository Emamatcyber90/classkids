//
//  CardModel.swift
//  chemistry
//
//  Created by Fabrizio Citro on 03/02/18.
//  Copyright © 2018 The Horcruxes. All rights reserved.
//

import UIKit

class CardModel: NSObject, NSCoding {
    
    var element: String
    var image: UIImage
    let backImage: UIImage = #imageLiteral(resourceName: "back")
    
    
    init(element: String, image: UIImage) {
        self.element = element
        self.image = image
    }
    
    
    // - Coder and Decoder
    // Need it for save the instances of this class ( array ) into a text file.
    // Without this implementation is impossible to use the DataManager.
    
    internal required init?(coder aDecoder: NSCoder) {
        self.element = aDecoder.decodeObject(forKey: "element") as! String
        self.image = aDecoder.decodeObject(forKey: "image") as! UIImage
   
    }
    
    func encode(with encoder: NSCoder) {
        encoder.encode(self.element, forKey: "element")
        encoder.encode(UIImageJPEGRepresentation(self.image, 0.5), forKey: "image")
    }
}

