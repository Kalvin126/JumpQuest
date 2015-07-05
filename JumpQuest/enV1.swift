//
//  enV1.swift
//  JumpQuest
//
//  Created by Kalvin Loc on 7/2/15.
//  Copyright © 2015 Kalvin Loc. All rights reserved.
//

import Foundation

class enV1 : MapTileDesign {
    
    override init(){
        super.init()
        
        type = "enV1"
        setImage()
        
        potentials += [ MapTileDesignPotential(type: "bsc", x: -90, y: 0),
                        MapTileDesignPotential(type: "enH0", x: 0, y: 60),
                        MapTileDesignPotential(type: "enH1", x: 0, y: 0),
                        MapTileDesignPotential(type: "enV0", x: 0, y: 0),
                        MapTileDesignPotential(type: "enV1", x: 0, y: -60),
                        MapTileDesignPotential(type: "enV1", x: 0, y: 60),
                        MapTileDesignPotential(type: "edU", x: 0, y: 0),
                        MapTileDesignPotential(type: "edD", x: 0, y: 60),
                        MapTileDesignPotential(type: "slLU", x: 0, y: 60),
                        MapTileDesignPotential(type: "slLD", x: 0, y: 0)]
    }
    
}
