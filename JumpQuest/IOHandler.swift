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
        let keyPressed = Int(s[s.startIndex].value)
        
        switch keyPressed {
        case NSUpArrowFunctionKey:
            return // TODO: Rope/Ladder movement
            
        case NSDownArrowFunctionKey:
            char?.prone()
            
        case NSRightArrowFunctionKey:
            if char?.orientation != "Right" {
                char?.changeOrientationTo("Right")
            }
            
            char?.walk()
            
        case NSLeftArrowFunctionKey:
            if char?.orientation != "Left" {
                char?.changeOrientationTo("Left")
            }
            
            char?.walk()
            
        case 32: // space bar
            char?.jump()
            
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
        let s = theEvent.charactersIgnoringModifiers!.unicodeScalars
        let keyDepressed = Int(s[s.startIndex].value)
        
        if keyDepressed != 32 {
            char?.stopDynamicActions()
        }
    }
}