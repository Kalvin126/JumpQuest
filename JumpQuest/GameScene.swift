//
//  GameScene.swift
//  JumpQuest
//
//  Created by Kalvin Loc on 6/30/15.
//  Copyright (c) 2015 Kalvin Loc. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    override func didMoveToView(view: SKView) {
    
        let path = NSBundle.mainBundle().pathForResource("101000100", ofType: "txt")
        let mapData = NSData(contentsOfFile: path!)
        
        do {
            let jsonResult = try NSJSONSerialization.JSONObjectWithData(mapData!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
            let mapElements = jsonResult.valueForKey("imgdir")?.valueForKey("imgdir") as! NSArray
            
            for e in mapElements {
                if e is NSDictionary{
                    if e.valueForKey("-name") as! String == "5" {
                        var cords = e.valueForKey("imgdir") as! NSArray
                        cords = cords[1].valueForKey("imgdir") as! NSArray
                        
                        for n in cords {
                            if n is NSDictionary{
                                let intVals = n.valueForKey("int") as! NSArray
                                let x = Int(intVals[0].valueForKey("-value") as! String)
                                let y = Int(intVals[1].valueForKey("-value") as! String)
                                let no = intVals[2].valueForKey("-value") as! String
                                let u = n.valueForKey("string")!.valueForKey("-value") as! String
                                
                                let spriteTextureName:String = u + "." + no
                                
                                let sprite = SKSpriteNode(imageNamed: spriteTextureName)
                                sprite.position = CGPointMake(CGFloat(x!), CGFloat(y!))
                                sprite.setScale(1)
                                
                                self.addChild(sprite)
                            }
                        }
                    }
                }
            }
        } catch {
            
        }
    }
    
    override func mouseDown(theEvent: NSEvent) {
        /* Called when a mouse click occurs */
        
        let location = theEvent.locationInNode(self)
        
        let sprite = SKSpriteNode(imageNamed:"edU.0")
        sprite.position = location;
        
        let action = SKAction.rotateByAngle(CGFloat(M_PI), duration:1)
        sprite.runAction(SKAction.repeatActionForever(action))
        
        self.addChild(sprite)
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
