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
    
    
    // - Singleton

    static let shared = DataManager()
    
    // - Cointainer of CardModel instances
    
    var storage : [CardModel] = []
    var filePath: String!
    
    func loadData() {

    }

    
    func save() {
        
    }
    
    func folderDocuments () -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        //print(paths[0])
        return paths[0]
    }
    
//   - makeCardArray function takes the bundle as input and return an array of cards
    
    func makeCardsArray() -> [CardModel] {
        var cards: [CardModel] = []
        
        let bundleName = "elem.bundle"
        let fileManager = FileManager.default
        let bundleURL = Bundle.main.bundleURL
        let assetURL = bundleURL.appendingPathComponent(bundleName)
        let contents = try! fileManager.contentsOfDirectory(at: assetURL, includingPropertiesForKeys: [URLResourceKey.nameKey, URLResourceKey.isDirectoryKey], options: .skipsHiddenFiles)
        for item in contents
        {
            if let image = UIImage(named: item.lastPathComponent, in: Bundle(url: assetURL) , compatibleWith: nil) {
                let card = CardModel(id: 0, image: image)
                cards.append(card)
            }
        }
        return cards
    }
    
    
}
