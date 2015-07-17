//
//  MapLR.swift
//  JumpQuest
//
//  Created by Kalvin Loc on 7/17/15.
//  Copyright © 2015 Kalvin Loc. All rights reserved.
//

import Foundation

class MapLR : MapItem {
    // MapLRSide?
    
    var l:Int?
    var uf:Int?
    // var x - inherited
    // var y - y1
    var y2:Int?
    var page:Int?
    
    override init(ID:Int){
        super.init(ID: ID)
    }
    
    func isPointInArea(x:Int, y:Int) -> Bool {
        let dist = distanceBetweenPointToLine(x, y, self.x!, self.y!, self.x!, self.y2!);
        
        return (dist <= 5)
    }
    
}
