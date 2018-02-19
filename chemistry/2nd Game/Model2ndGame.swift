//
//  Model.swift
//  test
//
//  Created by Alessandro Falgiano on 14/02/18.
//  Copyright © 2018 Alessandro Falgiano. All rights reserved.
//

import Foundation
import UIKit

var elementsArray = ["H", "O", "Na", "C", "Ca", "S", "Cl", "Cu", "F", "I", "Zn", "Au", "Sn", "P", "Br", "Ti", "Mg", "Ag", "As", "N"]

var formulaDictionary = [ "Camphor": "C10H16O",  "Bromine": "Br2",  "Nitrate": "NO3−",  "Carbonic Acid": "H2CO3",  "Sodium Nitrate": "NaNO3",  "Aluminium foil": "Al2O3",  "Arsenic Trioxide": "As4O3",  "Magnesium Bromide": "MgBr2",  "Copper Sulfate": "CuSO4",  "Glucose": "C6H12O6",  "Sucrose": "C12H22O11",  "Carbon Monoxide": "CO",  "Baking Soda": "NaHCO3",  "Propane": "C3H8",  "Silver Oxide": "AgI",  "Sodium Hypochlorite": "NaClO",  "Oxygen": "O2",  "Carbon Dioxide": "CO2",  "Ammonium Sulfate": "(NH4)2SO4",  "Aspirin": "C9H8O4",  "Lactic Acid": "C3H6O3",  "Nitrogen": "N2O",  "Gold Trioxide": "Au2O3",  "Butane": "C4H10",  "Pentane": "C5H12",  "Benzene": "C6H6",  "Sodium Cyanide": "NaCN",  "Hydrogen Sulfide": "H2S",  "Octane": "C8H18",  "Hydrobromic Acid": "HBr",  "Ascorbic Acid": "C6H8O6",  "Ammonia": "NH3",  "Methane": "CH4",  "Zinc": "Zn(NO3)2",  "Calcium Oxide": "CaO",  "Fluoride": "F2",  "Caffeine": "C8H10N4O2",  "Sugar": "CnH2nOn",  "Sulfate": "O4S2-",  "Vinegar": "C2H4O2",  "Hydrochloric Acid": "HCl",  "Peroxide": "H2O2",  "Calcium Cyanide": "Ca(CN)2",  "Sulfuric Acid": "H2SO4",  "Acetone": "CH3COCH3",  "Sodium Hydroxide": "NaOH",  "Cholesterol": "C27H46O",  "Ethane": "C2H6",  "Water": "H2O",  "Alcohol": "C2H6O",  "Salt": "NaCl",  "Benzoic Acid": "C7H6O2",  "Sulfurous Acid": "H2SO3",  "Methanol": "CH3OH",  "Sulfate Group": "CaSO4",  "Phosphoric Acid": "H3PO4",  "Iodic Acid": "HIO3",  "Citric Acid": "C6H8O7"]


func randomValue() -> String {
    let index: Int = Int(arc4random_uniform(UInt32(formulaDictionary.count)))
    let randomVal = Array(formulaDictionary.keys)[index]
    return randomVal
}

