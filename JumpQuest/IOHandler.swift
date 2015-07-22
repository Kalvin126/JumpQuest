//
//  IOHandler.swift
//  JumpQuest
//
//  Created by Kalvin Loc on 7/20/15.
//  Copyright © 2015 Kalvin Loc. All rights reserved.
//

import SpriteKit

extension GameScene {
    
    override func mouseEntered(theEvent: NSEvent) {
        
    }
    
    override func mouseExited(theEvent: NSEvent) {
        
    }
    
    override func mouseDown(theEvent: NSEvent) {
        let location = theEvent.locationInNode(self)
        
        print("Clicked at \(location)")
        
        if clickTele {
            char?.position = location
        }
    }
    
    override func mouseDragged(theEvent: NSEvent) {
        let cCameraPos = camera?.position
        let newPosition = CGPointMake(((cCameraPos?.x)! - theEvent.deltaX), ((cCameraPos?.y)! + theEvent.deltaY))
        
        camera?.position = newPosition
    }
    
    override func keyDown(theEvent: NSEvent) {
        super.keyDown(theEvent)
        
        let s = theEvent.charactersIgnoringModifiers!.unicodeScalars
        let s1 = Int(s[s.startIndex].value)
        
        switch s1 {
        case NSUpArrowFunctionKey:
            return // TODO: Rope/Ladder movement
            
        case NSDownArrowFunctionKey:
            if let proneAction = SKAction(named: ("prone" + charOrientation)) {
                char?.runAction(proneAction, withKey: "current")
            }
            
        case NSRightArrowFunctionKey:
            char?.removeAllActions()
            
            charOrientation = "Right"
            if let newIdle = SKAction(named: "idleRight") {
                char?.runAction(SKAction.repeatActionForever(newIdle))
            }
            
            if let action = SKAction(named: "walkRight"){
                char?.runAction(SKAction.repeatActionForever(action), withKey: "current") // Does not actually reapeatForever?
            }
            
        case NSLeftArrowFunctionKey:
            char?.removeAllActions()
            
            charOrientation = "Left"
            if let newIdle = SKAction(named: "idleLeft") {
                char?.runAction(SKAction.repeatActionForever(newIdle))
            }
            
            if let action = SKAction(named: "walkLeft") {
                char?.runAction(SKAction.repeatActionForever(action), withKey: "current")
            }
            
        case 32: // space bar
            if let jumpAction = SKAction(named: "jump" + charOrientation) where !jumping {
                jumping = true
                char?.runAction(SKAction.repeatActionForever(jumpAction), withKey: "jumping")
                char?.physicsBody?.applyImpulse(CGVectorMake(0.0, 100.0))
            }
            
        case 99: // c - center camera on char
            camera?.position = (char?.position)!
            
        case 116: // t - toggle click teleport char
            clickTele = !clickTele
            
        case 39: // ]
            camera?.xScale += 0.1
            camera?.yScale += 0.1
            
        case 93: // '
            camera?.xScale -= 0.1
            camera?.yScale -= 0.1
            
        default:
            return
        }
    }
    
    override func keyUp(theEvent: NSEvent) {
        char?.removeActionForKey("current")
    }
    
    override func performKeyEquivalent(theEvent: NSEvent) -> Bool {
        return true
    }
}