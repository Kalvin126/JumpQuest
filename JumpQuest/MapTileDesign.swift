//
//  MapTileDesign.swift
//  JumpQuest
//
//  Created by Kalvin Loc on 7/2/15.
//  Copyright © 2015 Kalvin Loc. All rights reserved.
//

import Foundation

class MapTileDesign {
    
    var size:(width:Int, height:Int)?
    
    var type:String?
    var potentials:[MapTileDesignPotential]
    
    weak var parent:MapTile?
    
    init(){
        potentials = []
    }
    
    func setImage() {
        // Image = MapEditor.file.Directory.GetIMG("Tile/blackTile.img").GetChild(type + "/0")
    }
    
    func getMath(type:String, var x:Int, var y:Int, multi:Int) -> (x:Int, y: Int)? {
        x -= (parent?.x)!
        y -= (parent?.y)!
        
        for p in potentials {
            if p.IsMatch(type, x:x, y:y, multi:multi) {
                return (x:(p.x! * multi + (parent?.x)!), y:(p.y! * multi + (parent?.y)!))
            }
        }
        
        return nil
    }
}
