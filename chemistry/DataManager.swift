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
    
    let helium = CardModel(element: "Helium", image: #imageLiteral(resourceName: "Helium"))
    
    func loadData() {
        filePath = folderDocuments() + "/cards.plist"
        storage = NSKeyedUnarchiver.unarchiveObject(withFile: filePath) as! [CardModel]
    }
    
    func initialize() {
        storage = makeCards("elem.bundle")
    }
    
    
    func save() {
        
    }
    
    func folderDocuments () -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        //print(paths[0])
        return paths[0]
    }
    
//   - makeCard function takes the bundle as input and return an array of cards
    
    func makeCards(_ bundle: String) -> [CardModel] {
        
        var cards: [CardModel] = []
        var photoArr: [UIImage] = []
        var stringArr: [String] = []
        (photoArr, stringArr) = DataManager.loadImages(bundleName: bundle)
        for i in 0..<photoArr.count {
            let name = stringArr[i]//.components(separatedBy: ".")
            let photo = photoArr[i]
            
            cards.append(CardModel(element: name, image: photo))
        }
        
        return cards
    }
    
//    - loadsImages function takes a bundle of elements and splits each elemen in text and image.
    
    public static func loadImages(bundleName: String) -> ([UIImage], [String]){
        var images = [UIImage]()
        let fileManager = FileManager.default
        let bundleURL = Bundle.main.bundleURL
        let assetURL = bundleURL.appendingPathComponent(bundleName)
        let contents = try! fileManager.contentsOfDirectory(at: assetURL, includingPropertiesForKeys: [URLResourceKey.nameKey, URLResourceKey.isDirectoryKey], options: .skipsHiddenFiles)
        var stringArr : [String] = []
        for item in contents
        {
            if let image = UIImage(named: item.lastPathComponent, in: Bundle(url: assetURL) , compatibleWith: nil) {
                images.append(image)
                stringArr.append(item.lastPathComponent)
            }
            
            print(item.lastPathComponent)
        }
        return (images, stringArr)
    }
    
    
}
