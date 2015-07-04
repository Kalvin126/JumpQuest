//
//  MapLayerObject.swift
//  JumpQuest
//
//  Created by Kalvin Loc on 7/2/15.
//  Copyright © 2015 Kalvin Loc. All rights reserved.
//

import Foundation

class MapLayerObject : MapItem {
    
    var lastKnown:(x:Int, y:Int)?
    var x2:Int?
    var y2:Int?
    var size:(height:Int, width:Int)?    // this should be protected..
    var cached:Bool? = false
    
    override init(){
    }
    
}
