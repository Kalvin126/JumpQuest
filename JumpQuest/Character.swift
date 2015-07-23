//
//  Character.swift
//  JumpQuest
//
//  Created by Kalvin Loc on 6/30/15.
//  Copyright © 2015 Kalvin Loc. All rights reserved.
//

import SpriteKit

class Character : SKSpriteNode {
    
    var orientation:String = "Right"    // Should only be "Right" or "Left" - Default: Right
    var jumping:Bool = false
    var walking:Bool = false

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        physicsBody?.friction = 0.0
        physicsBody?.restitution = 0.0
        physicsBody?.angularDamping = 0.0
        physicsBody?.linearDamping = 0.0
        
        physicsBody?.categoryBitMask = ColliderType.ColliderTypePlayer.rawValue
        physicsBody?.contactTestBitMask = ColliderType.ColliderTypeWall.rawValue
    }
    
    func stopDynamicActions() {
        let velocity = physicsBody?.velocity   // need to maintain x velo if jumping
        print("oVelo - \(velocity!)")
        
        removeActionForKey("dynamicAct")
        if walking {
            walking = !walking
        }
        physicsBody?.applyImpulse(CGVectorMake((velocity?.dx)!, 0.0)) // restore velo
        print("cVelo - \((physicsBody?.velocity)!)")
    }
    
    func jump() {
        if let jumpAction = SKAction(named: "jump" + orientation) where !jumping {
            jumping = true
            runAction(SKAction.repeatActionForever(jumpAction), withKey: "jumping")
            physicsBody?.applyImpulse(CGVectorMake(0.0, 100.0))
        }
    }
    
    func collidedWithFloor() {
        if jumping {
            jumping = !jumping
            removeActionForKey("jumping")
        }
    }
    
    func changeOrientationTo(direction:String) {
        orientation = direction
        
        if let newIdle = SKAction(named: "idle" + direction) {  // handle resting orientation
            runAction(SKAction.repeatActionForever(newIdle))
        }
        
        if jumping {    // handle jump animation orientation change
            removeActionForKey("jumping")
            
            // ooo sql like where statement!
            if let jumpAction = SKAction(named: "jump" + direction) {
                jumping = true
                runAction(SKAction.repeatActionForever(jumpAction), withKey: "jumping")
            }
        }
    }
    
    func walk() {
        if let action = SKAction(named: "walk" + orientation) where !jumping {
            walking = true
            runAction(SKAction.repeatActionForever(action), withKey: "dynamicAct")
        }
    }
    
    func prone() {
        if let proneAction = SKAction(named: ("prone" + orientation)) {
            runAction(proneAction, withKey: "dynamicAct")
        }
    }
    
}
