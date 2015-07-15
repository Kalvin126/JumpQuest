//
//  GameScene.swift
//  JumpQuest
//
//  Created by Kalvin Loc on 6/30/15.
//  Copyright (c) 2015 Kalvin Loc. All rights reserved.
//

import SpriteKit

enum ColliderType : UInt32 {
    case ColliderTypePlayer
    case ColliderTypeWall
}

class GameScene: SKScene, NSXMLParserDelegate, SKPhysicsContactDelegate {
    
    var char:SKSpriteNode?
    let mainMap = Map()
    
    override func didMoveToView(view: SKView) {
        
        physicsWorld.contactDelegate = self
        
        char = self.childNodeWithName("char") as? SKSpriteNode
        char?.physicsBody?.friction = 0.0
        char?.physicsBody?.angularDamping = 0.0
        char?.physicsBody?.linearDamping = 0.0
        char?.physicsBody?.categoryBitMask = ColliderType.ColliderTypePlayer.rawValue
        char?.physicsBody?.contactTestBitMask = ColliderType.ColliderTypePlayer.rawValue
        
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
                
                self.addChild(sprite)
            }
        }
        
        for fh in mainMap.footholds {
            let fhShape = CGPathCreateMutable()
            CGPathMoveToPoint(fhShape, nil, CGFloat(fh.x1!), CGFloat(-fh.y1!))
            CGPathAddLineToPoint(fhShape, nil, CGFloat(fh.x2!), CGFloat(-fh.y2!))
            
            let node = SKShapeNode(path: fhShape)
            node.strokeColor = NSColor.redColor()
            node.physicsBody = SKPhysicsBody(edgeLoopFromPath: fhShape)
            node.physicsBody?.restitution = 0
            node.physicsBody?.angularDamping = 0.0
            node.physicsBody?.linearDamping = 0.0
            node.physicsBody?.friction = 0.0
            node.physicsBody?.dynamic = false
            node.physicsBody?.categoryBitMask = ColliderType.ColliderTypeWall.rawValue
            
            self.addChild(node)
        }
    }
    
//    func createBackgroundNode() ->SKNode {
//
//    }
    
    override func mouseDown(theEvent: NSEvent) {
        let location = theEvent.locationInNode(self)
        
        print("Clicked at \(location)")
        char?.position = location
    }
    
    override func mouseDragged(theEvent: NSEvent) {
        let cCameraPos = camera?.position
        let newPosition = CGPointMake(((cCameraPos?.x)! - theEvent.deltaX), ((cCameraPos?.y)! + theEvent.deltaY))
        
        camera?.position = newPosition
    }
    
    override func keyDown(theEvent: NSEvent) {
        super.keyDown(theEvent)
        
        let s = theEvent.charactersIgnoringModifiers!
        let s1 = s.unicodeScalars
        let s2 = s1[s1.startIndex].value
        let s3 = Int(s2)
        
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
            let action = SKAction(named: "WalkRight")!
            char?.runAction(SKAction.repeatActionForever(action), withKey: "current")
            
        case NSLeftArrowFunctionKey:
            let action = SKAction(named: "WalkLeft")!
            char?.runAction(SKAction.repeatActionForever(action), withKey: "current")
            
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
    
    func didBeginContact(contact: SKPhysicsContact) {
        
        if contact.contactNormal.dx > 0.0 {
            char?.physicsBody?.velocity.dx = 0.0
        }
        if contact.contactNormal.dy > 0.0 {
            char?.physicsBody?.velocity.dy = 0.0
        }
//        var char:SKPhysicsBody
//        var footholdWall:SKPhysicsBody
//        
//        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
//            char = contact.bodyA;
//            footholdWall = contact.bodyB;
//        }else{
//            char = contact.bodyB;
//            footholdWall = contact.bodyA;
//        }
    }
}
