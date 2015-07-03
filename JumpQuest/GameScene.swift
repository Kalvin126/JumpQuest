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
    
        let path = NSBundle.mainBundle().pathForResource("101000101", ofType: "txt")
        let mapData = NSData(contentsOfFile: path!)
        
        do {
            let jsonResult = try NSJSONSerialization.JSONObjectWithData(mapData!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
            let mapElements = jsonResult.valueForKey("imgdir")?.valueForKey("imgdir") as! NSArray
            
            for e in mapElements {
                if e is NSDictionary{
                    let section = e.valueForKey("-name") as! String
                    
                    if section == "0" || section == "1" || section == "3"  {
                        var cords = e.valueForKey("imgdir") as! NSArray
                        cords = cords[1].valueForKey("imgdir") as! NSArray
                        
                        for n in cords {
                            if n is NSDictionary{
                                let intVals = n.valueForKey("int") as! NSArray
                                let x = Int(intVals[0].valueForKey("-value") as! String)
                                let y = Int(intVals[1].valueForKey("-value") as! String)
                                let zM = Int(intVals[3].valueForKey("-value") as! String)
                                let no = intVals[2].valueForKey("-value") as! String
                                let u = n.valueForKey("string")!.valueForKey("-value") as! String
                                
                                let spriteTextureName:String = u + "." + no
                                
                                let sprite = SKSpriteNode(imageNamed: spriteTextureName)
                                //sprite.anchorPoint = CGPointMake(0.6, -0.7)
                                sprite.position = CGPointMake(CGFloat(x!), CGFloat(-y!))
                                sprite.zPosition = CGFloat(zM!)
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
        
        let sprite = SKSpriteNode(imageNamed:"edD.0")
        sprite.anchorPoint = CGPointMake(0.0, 1.0)
        sprite.position = location;
        
        self.addChild(sprite)
    }
    
    override func keyDown(theEvent: NSEvent) {
        super.keyDown(theEvent)
        
        let s   =   theEvent.charactersIgnoringModifiers!
        let s1  =   s.unicodeScalars
        let s2  =   s1[s1.startIndex].value
        let s3  =   Int(s2)
        
        switch s3 {
        case NSUpArrowFunctionKey:
            camera?.runAction(SKAction(named: "CMoveUp")!)
            return
            
        case NSDownArrowFunctionKey:
            camera?.runAction(SKAction(named: "CMoveDown")!)
            return
            
        case NSRightArrowFunctionKey:
            camera?.runAction(SKAction(named: "CMoveRight")!)
            return
            
        case NSLeftArrowFunctionKey:
            camera?.runAction(SKAction(named: "CMoveLeft")!)
            return
            
        case 39: // ]
            camera?.xScale += 0.1
            camera?.yScale += 0.1
            return
            
        case 93: // '
            camera?.xScale -= 0.1
            camera?.yScale -= 0.1
            return
            
        default:
            return
        }
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
