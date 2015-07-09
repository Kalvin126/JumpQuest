//
//  MapTile.swift
//  JumpQuest
//
//  Created by Kalvin Loc on 7/2/15.
//  Copyright © 2015 Kalvin Loc. All rights reserved.
//

import Foundation

class MapTile : MapItem {
    
    var u:String?
    var no:Int?
    var zM:Int?
    
    var design:MapTileDesign?
    var footholds:[MapFootHoldDesign]?
    
    override init(ID:Int){
        
        super.init(ID: ID)
    }
    
//    func createFootholddesignList(){
//        if let entry = image.GetChild("foothold") as! IMGEntry {
//            for e:IMGEntry in entry.childs.Values {
//                let fh:MapFootholdDesign = MapFootholdDesign()
//                fh.object = object
//                fh.image = e
//                footholds.Add(fh)
//            }
//        }
//    }
    
    func setDesign(type:String){
        switch (type){
            case "bsc":     design = bsc()
            case "enH0":    design = enH0()
            case "enH1":    design = enH1()
            case "enV0":    design = enV0()
            case "enV1":    design = enV1()
            case "edU":     design = edU()
            case "edD":     design = edD()
            case "slLU":    design = slLU()
            case "slRU":    design = slRU()
            case "slLD":    design = slLD()
            case "slRD":    design = slRD()
            default:
                return
        }
        design?.parent = self
    }
}
