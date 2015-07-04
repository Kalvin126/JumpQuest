//
//  MapFoothold.swift
//  JumpQuest
//
//  Created by Kalvin Loc on 7/3/15.
//  Copyright © 2015 Kalvin Loc. All rights reserved.
//

import Foundation
import Darwin

class MapFoothold : MapItem {

    //var s1/s2:MapFootholdSide?
    var group:MapFootHolds?
    
    init(ID:Int){
        
    }
    
    func distance(x1:Double, y1:Double, x2:Double, y2:Double) -> Double{
        return sqrt( pow(x2-x1, 2) + pow(y2-y1, 2) )
    }
}
