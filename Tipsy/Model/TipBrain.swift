//
//  TipBrain.swift
//  Tipsy
//
//  Created by Ryan Anderson on 12/8/21.
//  Copyright © 2021 The App Brewery. All rights reserved.
//

import Foundation
import UIKit

struct TipBrain {
    
    func getPctFromString(_ tipTitle: String) -> Double {
        let tip = tipTitle.dropLast()
        let tipDouble = Double(tip)!
        return tipDouble / 100
    }
    
    func calculateTotal( total: Double, tipPct: Double, theSplit: Double) -> Double {
    let totalPlusTip = (total * tipPct) + total
    return totalPlusTip / theSplit
    }
}
