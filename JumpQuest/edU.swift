//
//  edU.swift
//  JumpQuest
//
//  Created by Kalvin Loc on 7/2/15.
//  Copyright © 2015 Kalvin Loc. All rights reserved.
//

import Foundation

class edU : MapTileDesign {
    
    override init(){
        super.init()
        
        type = "edU"
        potentials += [ MapTileDesignPotential(type: "enH0", x: -90, y: 0),
                        MapTileDesignPotential(type: "enH0", x: 0, y: 0),
                        MapTileDesignPotential(type: "enV0", x: 0, y: 0),
                        MapTileDesignPotential(type: "enV1", x: 0, y: 0),
                        MapTileDesignPotential(type: "edD", x: 0, y: 0),
                        MapTileDesignPotential(type: "slLU", x: 90, y: 0),
                        MapTileDesignPotential(type: "slLU", x: 0, y: 60),
                        MapTileDesignPotential(type: "slRU", x: -90, y: 0),
                        MapTileDesignPotential(type: "slRU", x: 0, y: 60)]
    }
}

