//
//  enH1.swift
//  JumpQuest
//
//  Created by Kalvin Loc on 7/2/15.
//  Copyright © 2015 Kalvin Loc. All rights reserved.
//

import Foundation

class enH1 : MapTileDesign {
    
    override init(){
        super.init()
        
        type = "enH1"
        setImage()
        
        potentials += [ MapTileDesignPotential(type: "bsc", x: 0, y: -60),
                        MapTileDesignPotential(type: "enH0", x: 0, y: 0),
                        MapTileDesignPotential(type: "enH1", x: -90, y: 0),
                        MapTileDesignPotential(type: "enH1", x: 90, y: 0),
                        MapTileDesignPotential(type: "edD", x: 0, y: 0),
                        MapTileDesignPotential(type: "edD", x: 90, y: 0),
                        MapTileDesignPotential(type: "enV0", x: 90, y: 0),
                        MapTileDesignPotential(type: "enV1", x: 0, y: 0),
                        MapTileDesignPotential(type: "slLU", x: 90, y: 0),
                        MapTileDesignPotential(type: "slRU", x: 0, y: 0),
                        MapTileDesignPotential(type: "slLD", x: 0, y: -60),
                        MapTileDesignPotential(type: "slLD", x: 180, y: 0),
                        MapTileDesignPotential(type: "slRD", x: 90, y: -60),
                        MapTileDesignPotential(type: "slRD", x: -90, y: 0)]
    }
    
}
