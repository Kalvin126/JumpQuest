//
//  GameScene.swift
//  JumpQuest
//
//  Created by Kalvin Loc on 6/30/15.
//  Copyright (c) 2015 Kalvin Loc. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, NSXMLParserDelegate {
    override func didMoveToView(view: SKView) {
        let mainMap = Map()
        
        self.children
    }
    
//    func createBackgroundNode() ->SKNode {
//        
//    }
    
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
