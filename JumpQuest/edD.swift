//
//  edD.swift
//  JumpQuest
//
//  Created by Kalvin Loc on 7/2/15.
//  Copyright © 2015 Kalvin Loc. All rights reserved.
//

import Foundation

class edD : MapTileDesign {
    
    override init(){
        super.init()
        
        type = "edD"
        setImage()
        
        potentials.append( MapTileDesignPotential(type: "enH1", x: -90, y: 0) )
        potentials.append( MapTileDesignPotential(type: "enH1", x: 0, y: 0) )
        potentials.append( MapTileDesignPotential(type: "enV0", x: 0, y: -60) )
        potentials.append( MapTileDesignPotential(type: "enV1", x: 0, y: -60) )
        potentials.append( MapTileDesignPotential(type: "edU", x: 0, y: 0) )
        potentials.append( MapTileDesignPotential(type: "slLD", x: 90, y: 0) )
        potentials.append( MapTileDesignPotential(type: "slLD", x: 0, y: -60) )
        potentials.append( MapTileDesignPotential(type: "slRD", x: -90, y: 0) )
        potentials.append( MapTileDesignPotential(type: "slRD", x: 0, y: -60) )
    }
}
