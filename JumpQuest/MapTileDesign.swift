//
//  MapTileDesign.swift
//  JumpQuest
//
//  Created by Kalvin Loc on 7/2/15.
//  Copyright © 2015 Kalvin Loc. All rights reserved.
//

import Foundation

class MapTileDesign : MapTile {
    
    var type:String
    var potentials:[MapTileDesignPotential]
    
    override init(){
        type = ""
        potentials = []
        
        super.init()
    }
    
    func setImage() {
        // Image = MapEditor.file.Directory.GetIMG("Tile/blackTile.img").GetChild(type + "/0")
    }
    
    func getMath(type:String, x:Int, y:Int, multi:Int) -> (x:Int, y:Int) -> (x:Int, y: Int){
        x -= object.getInt("x");
        y -= object.getInt("y");
        
        for p:MapTileDesignPotential in potentials {
            if p.IsMatch(type, x: x, y:y, multi:multi) {
                return (x:p.x * multi + object.getInt("x"), y:p.y * multi + object.getInt("y"))
            }
        }
        
        return (x:0xffff, y:0xffff); // need null val
    }
}
