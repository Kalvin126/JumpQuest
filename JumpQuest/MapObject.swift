//
//  MapObject.swift
//  JumpQuest
//
//  Created by Kalvin Loc on 7/25/15.
//  Copyright © 2015 Kalvin Loc. All rights reserved.
//

import Foundation

class MapObject : MapItem {
    
    var oS:String?
    var l0:String?
    var l1:String?
    var l2:String?
    var z:Int?
    var f:Int?
    var zM:Int?
    
    override init(ID:Int){
        
        super.init(ID: ID)
    }
}
