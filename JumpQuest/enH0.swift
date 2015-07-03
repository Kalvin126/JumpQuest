//
//  enH0.swift
//  JumpQuest
//
//  Created by Kalvin Loc on 7/2/15.
//  Copyright © 2015 Kalvin Loc. All rights reserved.
//

import Foundation

class enH0 : MapTileDesign {
    
    override init(){
        type = "enH0"
        
        setImage()
        
        potentials.append( MapTileDesignPotential("bsc", 0, 0) )
        potentials.append( MapTileDesignPotential("enH0", -90, 0) )
        potentials.append( MapTileDesignPotential("enH0", 90, 0) )
        potentials.append( MapTileDesignPotential("enH1", 0, 0) )
        potentials.append( MapTileDesignPotential("edU", 0, 0) )
        potentials.append( MapTileDesignPotential("edU", 90, 0) )
        potentials.append( MapTileDesignPotential("enV0", 90, -60) )
        potentials.append( MapTileDesignPotential("enV1", 0, -60) )
        potentials.append( MapTileDesignPotential("slLU", 0, 60) )
        potentials.append( MapTileDesignPotential("slLU", 180, 0) )
        potentials.append( MapTileDesignPotential("slRU", 90, 60) )
        potentials.append( MapTileDesignPotential("slRU", -90, 0) )
        potentials.append( MapTileDesignPotential("slLD", 90, 0) )
        potentials.append( MapTileDesignPotential("slRD", 0, 0) )
    }
    
}
