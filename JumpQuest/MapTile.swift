//
//  MapTile.swift
//  JumpQuest
//
//  Created by Kalvin Loc on 7/2/15.
//  Copyright © 2015 Kalvin Loc. All rights reserved.
//

import Foundation

#if os(iOS)
    import UIKit
#elseif os(OSX)
    import AppKit
#endif

class MapTile : MapItem {
    
    var u:String?
    var no:Int?
    var zM:Int?
    
    var design:MapTileDesign
    var footholds:[MapFootHoldDesign]?
    
    override init(ID:Int){
        design = MapTileDesign()
        
        super.init(ID: ID)
    }
    
    func setDesignSize() {
        let spriteTextureName:String = u! + ".\(no!)"
        
        #if os(iOS)
            if let texture = UIImage(named: spriteTextureName) {
                let size = texture.size
                design?.size = (width:Int(size.width), height:Int(size.height))
            }
        #elseif os(OSX)
            if let texture = NSImage(named: spriteTextureName) {
                let size = texture.size
                design.size = (width:Int(size.width), height:Int(size.height))
            }
        #endif
    }
}
