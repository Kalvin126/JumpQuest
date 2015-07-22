//
//  GameScene.swift
//  JumpQuest
//
//  Created by Kalvin Loc on 6/30/15.
//  Copyright (c) 2015 Kalvin Loc. All rights reserved.
//

import AVFoundation
import SpriteKit

let MUSIC:Bool = false

enum ColliderType : UInt32 {
    case ColliderTypePlayer
    case ColliderTypeWall
}

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    // character states - extensions cannot have stored properties...
    var char:SKSpriteNode?
    var charOrientation:String = "Right"    // Should only be "Right" or "Left" - Default: Right
    var jumping:Bool = false

    let mainMap = Map()
    var cursor:NSCursor?
    
    var clickTele = true
    var bgmPlayer:AVAudioPlayer?
    var effectPlayer:AVAudioPlayer?
    
    override func didMoveToView(view: SKView) {
        physicsWorld.contactDelegate = self
        
        // BGM
        if MUSIC {
            let dir = mainMap.bgm?.rangeOfString("/")
            let bgmName:String = (mainMap.bgm?.substringFromIndex(advance((dir?.startIndex)!, 1)))!
            if let path = NSBundle.mainBundle().pathForResource(bgmName, ofType:"mp3") {
                do {
                    bgmPlayer = try AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: path))
                    bgmPlayer!.prepareToPlay()
                    bgmPlayer!.play()
                }catch{
                    print(error)
                }
            }
        }
        
        // Cursor
        if let cursorImage = NSImage(named: "0.0") {
            cursor = NSCursor(image: cursorImage, hotSpot: NSPoint(x: 0, y: 3)) // correct hot point?
            view.addCursorRect(self.frame, cursor: cursor!)
            cursor?.setOnMouseEntered(true)
        }
        
        // character config
        char = self.childNodeWithName("char") as? SKSpriteNode
        char?.physicsBody?.friction = 0.0
        char?.physicsBody?.restitution = 0.0
        char?.physicsBody?.angularDamping = 0.0
        char?.physicsBody?.linearDamping = 0.0
        char?.physicsBody?.categoryBitMask = ColliderType.ColliderTypePlayer.rawValue
        char?.physicsBody?.contactTestBitMask = ColliderType.ColliderTypeWall.rawValue
        char?.physicsBody?.collisionBitMask = COLLISION_ON
        
        // tile placement
        for tile in mainMap.tiles {
            let spriteTextureName:String = tile.u! + ".\(tile.no!)"
            
            let sprite = SKSpriteNode(imageNamed: spriteTextureName)
            sprite.anchorPoint = CGPointMake(0.0, 1.0)
            
            if tile.u == "enH1" || tile.u == "edD" {
                if let pos = mainMap.getTileDesignPosition(tile){
                    sprite.position = CGPointMake(CGFloat(pos.x-20), CGFloat(-pos.y+40))
                }
            }else{
                sprite.position = CGPointMake(CGFloat(tile.x!-20), CGFloat(-tile.y!+40))
            }
            
            self.addChild(sprite)
        }
        
        // foothold placement/config
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
            node.physicsBody?.affectedByGravity = false
            node.physicsBody?.categoryBitMask = ColliderType.ColliderTypeWall.rawValue | COLLISION_OFF
            
            self.addChild(node)
        }
    }
    
//    func createBackgroundNode() ->SKNode {
//
//    }
    
    let COLLISION_ON:UInt32 = 0x00001000
    let COLLISION_OFF:UInt32 = 0x0
    let COLLIDED:NSColor = NSColor.greenColor()
    let COLLIDING:NSColor = NSColor.blueColor()
    
    func didBeginContact(contact: SKPhysicsContact) {
        print("Begin Contact at x:\(contact.contactNormal.dx) y:\(contact.contactNormal.dy)")
        var footholdWallPB:SKPhysicsBody
        
        if contact.bodyA.categoryBitMask == ColliderType.ColliderTypePlayer.rawValue {
            footholdWallPB = contact.bodyB;
        }else{
            footholdWallPB = contact.bodyA;
        }
        
        if contact.contactNormal.dx < 0 && contact.contactNormal.dy == 1.0 {    // Touched ground
            footholdWallPB.categoryBitMask = ColliderType.ColliderTypeWall.rawValue | COLLISION_ON
            (footholdWallPB.node as! SKShapeNode).strokeColor = COLLIDING
            
            if jumping {
                jumping = !jumping
                char?.removeActionForKey("jumping")
            }
        }
    }
    
    func didEndContact(contact: SKPhysicsContact) {
        var fh:SKShapeNode?
        
        if contact.bodyA.categoryBitMask == ColliderType.ColliderTypePlayer.rawValue {
            fh = contact.bodyB.node as? SKShapeNode
        }else{
            fh = contact.bodyA.node as? SKShapeNode
        }
        
        if (fh != nil) {
            fh!.physicsBody!.categoryBitMask = ColliderType.ColliderTypeWall.rawValue | COLLISION_OFF
            fh!.strokeColor = COLLIDED
        }
    }
}
