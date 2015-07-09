//
//  GameScene.swift
//  JumpQuest
//
//  Created by Kalvin Loc on 6/30/15.
//  Copyright (c) 2015 Kalvin Loc. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, NSXMLParserDelegate {
    
    var char:SKSpriteNode?
    let mainMap = Map()
    
    override func didMoveToView(view: SKView) {
        
        char = self.childNodeWithName("char") as? SKSpriteNode
        
        for tile in mainMap.tiles {
            let spriteTextureName:String = tile.u! + ".\(tile.no!)"
            
            let sprite = SKSpriteNode(imageNamed: spriteTextureName)
            //sprite.anchorPoint = CGPointMake(0.6, -0.7)
            if let pos = mainMap.getTileDesignPosition(tile){
                if tile.u! == "edD"{
                    sprite.position = CGPointMake(CGFloat(pos.x), CGFloat(-pos.y-28))
                }else if spriteTextureName == "enH1.0" {
                    sprite.position = CGPointMake(CGFloat(pos.x), CGFloat(-pos.y-26))
                }else if spriteTextureName == "enH1.1"{
                    sprite.position = CGPointMake(CGFloat(pos.x), CGFloat(-pos.y-45))
                }else if spriteTextureName == "enH1.2" {
                    sprite.position = CGPointMake(CGFloat(pos.x), CGFloat(-pos.y-38))
                }else{
                    sprite.position = CGPointMake(CGFloat(pos.x), CGFloat(-pos.y))
                }
                sprite.setScale(1)
                sprite.physicsBody = SKPhysicsBody(texture: sprite.texture!, size:( sprite.texture?.size())!)
                sprite.physicsBody?.dynamic = false
                sprite.physicsBody?.restitution = 0
                
                self.addChild(sprite)
            }

        }
    }
    
//    func createBackgroundNode() ->SKNode {
//
//    }
    
    override func mouseDown(theEvent: NSEvent) {
        let location = theEvent.locationInNode(self)
        
        print("Clicked at \(location)")
    }
    
    override func mouseDragged(theEvent: NSEvent) {
        let cCameraPos = camera?.position
        let newPosition = CGPointMake(((cCameraPos?.x)! - theEvent.deltaX), ((cCameraPos?.y)! + theEvent.deltaY))
        
        camera?.position = newPosition
    }
    
    override func keyDown(theEvent: NSEvent) {
        super.keyDown(theEvent)
        
        let s   =   theEvent.charactersIgnoringModifiers!
        let s1  =   s.unicodeScalars
        let s2  =   s1[s1.startIndex].value
        let s3  =   Int(s2)
        
        switch s3 {
        case NSUpArrowFunctionKey:
            if char?.actionForKey("jumping") == nil {
                let jumpAction = SKAction(named: "Jump")!
                char?.runAction(jumpAction, withKey: "jumping")
            }
            
        case NSDownArrowFunctionKey:
            let proneAction = SKAction(named: "ProneState")!
            char?.runAction(proneAction, withKey: "current")
            
        case NSRightArrowFunctionKey:
            char?.runAction(SKAction(named: "WalkRight")!, withKey: "current")
            
        case NSLeftArrowFunctionKey:
            char?.runAction(SKAction(named: "WalkLeft")!, withKey: "current")
            
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
    
    override func keyUp(theEvent: NSEvent) {
        char?.removeActionForKey("current")
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
