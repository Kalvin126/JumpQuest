//
//  MapTileDesignPotential.swift
//  JumpQuest
//
//  Created by Kalvin Loc on 7/2/15.
//  Copyright © 2015 Kalvin Loc. All rights reserved.
//

import Foundation

class MapTileDesignPotential {
    
    let type:String
    let x:Int
    let y:Int
    
    init(type:String, x:Int, y:Int){
        self.type = type
        self.x = x
        self.y = y
    }
    
    func IsMatch(type:String, x:Int, y:Int, multi:Int) -> Bool {
        //return this.type == type && MapFoothold.Distance(this.x * multi, this.y * multi, x, y) <= 15
        return 0
    }
    
}
