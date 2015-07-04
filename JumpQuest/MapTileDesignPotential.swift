//
//  MapTileDesignPotential.swift
//  JumpQuest
//
//  Created by Kalvin Loc on 7/2/15.
//  Copyright © 2015 Kalvin Loc. All rights reserved.
//

import Foundation

class MapTileDesignPotential {
    
    var type:String?
    var x:Int?
    var y:Int?
    
    init(){
    }
    
    init(type:String, x:Int, y:Int){
        self.type = type
        self.x = x
        self.y = y
    }
    
    func IsMatch(type:String, x:Int, y:Int, multi:Int) -> Bool {
        //return self.type == type && (MapFoothold.distance(x1:self.x * multi, y1:self.y * multi, x2:x, y2:y) <= 15)
        return false
    }
}
