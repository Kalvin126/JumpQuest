//
//  Extensions.swift
//  JumpQuest
//
//  Created by Kalvin Loc on 7/17/15.
//  Copyright © 2015 Kalvin Loc. All rights reserved.
//

import Foundation
import CoreGraphics

func distance(x1:Int, _ y1:Int, _ x2:Int, _ y2:Int) -> Int {
    let xDiff = x2 - x1
    let yDiff = y2 - y1
    
    return Int(sqrt(Float(xDiff*xDiff + yDiff*yDiff)))
}

func prod(x1:Int, _ y1:Int, _ x2:Int, _ y2:Int) -> Int {
    return (x1*x2) + (y1*y2)
}

// argument labels be gone! - Swift 2
func distanceBetweenPointToLine(x:Int, _ y:Int, _ x1:Int, _ y1:Int, _ x2:Int, _ y2:Int) -> Int {
    let dx = x2 - x1
    let dy = y2 - y1
    let vx = x - x1
    let vy = y - y1
    
    let t = prod(dx, dy, vx, vy)
    let d = prod(dx, dy, dx, dy)
    
    if t <= 0 {
        return distance(x, y, x2, y1)
    }else if t >= d{
        return distance(x, y, x2, y2)
    }else{
        return distance(x, y, (x1 + ((t/d)*dx)), (y1 + ((t/d)*dy)))
    }
}

extension CGVector {
    func magnitude() -> CGFloat {
        return sqrt((dx*dx) + (dy*dy))
    }
    
    static func CGVectorMakeWithPoints(fromPoint:CGPoint, toPoint:CGPoint) -> CGVector {
        return CGVectorMake(toPoint.x - fromPoint.x, toPoint.y - fromPoint.y);
    }
}