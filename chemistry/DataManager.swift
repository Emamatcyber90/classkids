//
//  DataManager.swift
//  chemistry
//
//  Created by Fabrizio Citro on 03/02/18.
//  Copyright © 2018 The Horcruxes. All rights reserved.
//

import Foundation

class DataManager {
    
    
    // - Singleton

    static let shared = DataManager()
    
    // - Cointainer of CardModel instances
    
    var array : [CardModel] = []

    func loadData() {
        
    }
    
    func save() {
        
    }
    
    func folderDocuments () -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        //print(paths[0])
        return paths[0]
    }
}
