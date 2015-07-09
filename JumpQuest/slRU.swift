//
//  slRU.swift
//  JumpQuest
//
//  Created by Kalvin Loc on 7/2/15.
//  Copyright © 2015 Kalvin Loc. All rights reserved.
//

import Foundation

class slRU : MapTileDesign {
    
    override init(){
        super.init()
        
        type = "slRD"
        potentials += [ MapTileDesignPotential(type: "bsc", x: -90, y: -60),
                        MapTileDesignPotential(type: "bsc", x: 0, y: 0),
                        MapTileDesignPotential(type: "enH0", x: -90, y: -60),
                        MapTileDesignPotential(type: "enH0", x: 90, y: 0),
                        MapTileDesignPotential(type: "enH1", x: 0, y: 0),
                        MapTileDesignPotential(type: "enV0", x: 0, y: -60),
                        MapTileDesignPotential(type: "edU", x: 90, y: 0),
                        MapTileDesignPotential(type: "edU", x: 0, y: -60),
                        MapTileDesignPotential(type: "slLU", x: 0, y: 0),
                        MapTileDesignPotential(type: "slLU", x: 180, y: 0),
                        MapTileDesignPotential(type: "slRU", x: 90, y: 60),
                        MapTileDesignPotential(type: "slRU", x: -90, y: -60),
                        MapTileDesignPotential(type: "slLD", x: 0, y: 0),
                        MapTileDesignPotential(type: "slLD", x: 0, y: -60),
                        MapTileDesignPotential(type: "slLD", x: 90, y: 0),
                        MapTileDesignPotential(type: "slRD", x: 0, y: 0)]
    }
    
}

