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

    var char:Character?

    let mainMap = Map()
    
    #if os(OSX)
        var cursor:NSCursor?
    #endif
    
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
        
        #if os(OSX)
            // Cursor
            if let cursorImage = NSImage(named: "0.0") {
                cursor = NSCursor(image: cursorImage, hotSpot: NSPoint(x: 0, y: 3)) // correct hot point?
                view.addCursorRect(self.frame, cursor: cursor!)
                cursor?.setOnMouseEntered(true)
            }
        #endif
            
        // character config
        char = self.childNodeWithName("char") as? Character
        char?.physicsBody?.collisionBitMask = COLLISION_ON
        
        // backTile placement
        for backTile in mainMap.backTiles {
            let spriteTextureName:String = "back" + ".\(backTile.no!)"
            
            let sprite = SKSpriteNode(imageNamed: spriteTextureName)
            sprite.position = CGPointMake(CGFloat(backTile.x!), CGFloat(backTile.y!))
            
            addChild(sprite)
        }
        
        // foothold placement/config
        for fh in mainMap.footholds {
            let fhShape = CGPathCreateMutable()
            CGPathMoveToPoint(fhShape, nil, CGFloat(fh.x1!), CGFloat(-fh.y1!))
            CGPathAddLineToPoint(fhShape, nil, CGFloat(fh.x2!), CGFloat(-fh.y2!))
            
            let node = SKShapeNode(path: fhShape)
            #if os(iOS)
                node.strokeColor = UIColor.redColor()
            #elseif os(OSX)
                node.strokeColor = NSColor.redColor()
            #endif
            node.physicsBody = SKPhysicsBody(edgeLoopFromPath: fhShape)
            node.physicsBody?.restitution = 0
            node.physicsBody?.angularDamping = 0.0
            node.physicsBody?.linearDamping = 0.0
            node.physicsBody?.friction = 0.0
            node.physicsBody?.dynamic = false
            node.physicsBody?.affectedByGravity = false
            node.physicsBody?.categoryBitMask = ColliderType.ColliderTypeWall.rawValue | COLLISION_OFF
            
            addChild(node)
        }
        
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
            
            addChild(sprite)
        }
        
        for obj in mainMap.objects {
            let spriteTextureName:String = obj.l0! + "." + obj.l1! + "." + obj.l2! + ".0"
            
            let sprite = SKSpriteNode(imageNamed: spriteTextureName)
            //sprite.anchorPoint = CGPointMake(0.0, 1.0)
            sprite.position = CGPointMake(CGFloat(obj.x!), CGFloat(-obj.y!))
            sprite.zPosition = CGFloat(obj.z!)
            
            addChild(sprite)
        }
        
    }
    
//    func createBackgroundNode() ->SKNode {
//
//    }
    
    let COLLISION_ON:UInt32 = 0x00001000
    let COLLISION_OFF:UInt32 = 0x0
    #if os(iOS)
        let COLLIDED:UIColor = UIColor.greenColor()
        let COLLIDING:UIColor = UIColor.blueColor()
    #elseif os(OSX)
        let COLLIDED:NSColor = NSColor.greenColor()
        let COLLIDING:NSColor = NSColor.blueColor()
    #endif
    
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
            
            char?.collidedWithFloor()
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
    
    override func update(currentTime: CFTimeInterval) {
        
        // detect character movement and move camera if necessary
        if camera?.actionForKey("cameraMove") == nil && !clickTele {
            if CGVector.CGVectorMakeWithPoints((char?.position)!, toPoint: (camera?.position)!).magnitude() > 60.0 {
                let cameraMoveAct = SKAction.moveTo((char?.position)!, duration: 1.0)
                cameraMoveAct.timingMode = .EaseOut
                camera?.runAction(cameraMoveAct, withKey: "cameraMove")
            }
        }
    }
}
