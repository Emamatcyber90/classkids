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
    
    func folderDocuments () -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        //print(paths[0])
        return paths[0]
    }
    
    func makeElementArray(bundleURL: URL) -> [Element] {
        var elements: [Element] = []
        
        let bundleName = "elem.bundle"
        let fileManager = FileManager.default
        let assetURL = bundleURL.appendingPathComponent(bundleName)
        let contents = try! fileManager.contentsOfDirectory(at: assetURL, includingPropertiesForKeys: [URLResourceKey.nameKey, URLResourceKey.isDirectoryKey], options: .skipsHiddenFiles)
        for item in contents
        {
            if let imageName = UIImage(named: item.lastPathComponent, in: Bundle(url: assetURL) , compatibleWith: nil) {
                let symbolString = item.lastPathComponent.getSecondImage()
                if let imageSymbol = UIImage(named: symbolString, in: Bundle(url:assetURL), compatibleWith: nil) {
                    let element = Element(id: item.lastPathComponent, name: imageName, symbol: imageSymbol)
                    elements.append(element)
                }
            }
        }
        return elements
    }
    
    
}

extension String {
    func getSecondImage () -> String {
        var string = self
        let ext = ".png"
        for _ in 0...3 {
            string.removeLast()
        }
        string.append("2")
        string.append(ext)
        return string
    }
}
