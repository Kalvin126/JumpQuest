//
//  Map.swift
//  JumpQuest
//
//  Created by Kalvin Loc on 7/3/15.
//  Copyright © 2015 Kalvin Loc. All rights reserved.
//

import Foundation

class Map : NSObject, NSXMLParserDelegate {
    
    var elementQueue:[String] = []
    
    var version:Int?
    var cloud:Int?
    var town:Int?
    var returnMap:Int?
    var mobRate:Float?
    var bgm:String?
    var mapDesc:String?
    var hideMinimap:Int?
    var forcedReturn:Int?
    var fieldLimit:Int?
    var mapMark:String?
    var swim:Int?
    
    override init(){
        super.init()
        
        let path = NSBundle.mainBundle().pathForResource("101000100", ofType: "xml")
        let mapData = NSData(contentsOfFile: path!)
        
        let parser = NSXMLParser(data: mapData!)
        parser.delegate = self
        parser.parse()
        
        /* Map structure:
        back
            #
                bS (string)
                no
                x
                y
                rx
                ry
                type
                cx
                cy
                a
                front
                ani
                f
        life
            #
                type (string)
                id
                x
                y
                mobTime
                f
                fh
                cy
                rx0
                rx1
        #
            info
            tile
            obj
            reactor ?
        foothold
            #
                #
                    #
                        x1
                        y2
                        x2
                        y2
                        prev
                        next
        ladderRope
            #
                l
                uf
                x
                y1
                y2
                page
        miniMap
            basedata?
            height
            name
            width
                width
                height
                centerX
                centerY
                mag
        portal
            #
                name (string)
                pt
                x
                y
                tm
                tno (string)
        info
            version
            cloud
            town
            returnMap
            mobRate
            bgm (string)
            mapDesc
            hideMinimap
            forcedReturn
            fieldLimit
            mapMark (string)
            swim
        */
    }
    
    private var currentSection:String?
    private var currentItemID:String?
    
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        elementQueue.append(elementName)
        
        if currentSection != nil {
            if currentSection == "back" {
                if currentItemID != nil {
                    if let attribute:String = attributeDict["name"], value:String = attributeDict["value"]{
                        switch attribute{
                            case "bS":
                                print("attribute: \(attribute) - \(value)")
                            case "no":
                                print("attribute: \(attribute) - \(value)")
                            case "x":
                                print("attribute: \(attribute) - \(value)")
                            case "y":
                                print("attribute: \(attribute) - \(value)")
                            case "rx":
                                print("attribute: \(attribute) - \(value)")
                            case "ry":
                                print("attribute: \(attribute) - \(value)")
                            case "type":
                                print("attribute: \(attribute) - \(value)")
                            case "cx":
                                print("attribute: \(attribute) - \(value)")
                            case "cy":
                                print("attribute: \(attribute) - \(value)")
                            case "a":
                                print("attribute: \(attribute) - \(value)")
                            case "front":
                                print("attribute: \(attribute) - \(value)")
                            case "ani":
                                print("attribute: \(attribute) - \(value)")
                            case "f":
                                print("attribute: \(attribute) - \(value)")
                        default:
                            print("Unknown attribute: \(attributeDict)")
                        }
                    }
                }else{
                    currentItemID = attributeDict["name"]
                }
                
            }
            else if currentSection == "life" {
                if currentItemID != nil {
                    if let attribute:String = attributeDict["name"], value:String = attributeDict["value"]{
                        switch attribute{
                        case "type":
                            print("attribute: \(attribute) - \(value)")
                        case "id":
                            print("attribute: \(attribute) - \(value)")
                        case "x":
                            print("attribute: \(attribute) - \(value)")
                        case "y":
                            print("attribute: \(attribute) - \(value)")
                        case "mobTime":
                            print("attribute: \(attribute) - \(value)")
                        case "f":
                            print("attribute: \(attribute) - \(value)")
                        case "fh":
                            print("attribute: \(attribute) - \(value)")
                        case "cy":
                            print("attribute: \(attribute) - \(value)")
                        case "rx0":
                            print("attribute: \(attribute) - \(value)")
                        case "rx1":
                            print("attribute: \(attribute) - \(value)")
                        default:
                            print("Unknown attribute: \(attributeDict)")
                        }
                    }
                }else{
                    currentItemID = attributeDict["name"]
                }
                
            }
            else if currentSection == "reactor" {
                print("section: \(currentSection)")
                
            }
            else if currentSection == "foothold" {
                print("section: \(currentSection)")
                
            }
            else if currentSection == "ladderRope"{
                if currentItemID != nil {
                    if let attribute:String = attributeDict["name"], value:String = attributeDict["value"]{
                        switch attribute{
                        case "l":
                            print("attribute: \(attribute) - \(value)")
                        case "uf":
                            print("attribute: \(attribute) - \(value)")
                        case "x":
                            print("attribute: \(attribute) - \(value)")
                        case "y1":
                            print("attribute: \(attribute) - \(value)")
                        case "y2":
                            print("attribute: \(attribute) - \(value)")
                        case "page":
                            print("attribute: \(attribute) - \(value)")
                        default:
                            print("Unknown attribute: \(attributeDict)")
                        }
                    }
                }else{
                    currentItemID = attributeDict["name"]
                }
                
            }
            else if currentSection == "miniMap" {
                let baseData:String? = attributeDict["basedata"]
                let height:String? = attributeDict["height"]
                let width:String? = attributeDict["width"]
                let centerX:String? = attributeDict["centerX"]
                let centerY:String? = attributeDict["centerY"]
                let mag:String? = attributeDict["mag"]
                
//                switch attributeDict["name"]! {
//                    case "canvas":
//                    case "width":
//                    case "height":
//                    case "centerX":
//                    case "centerY":
//                    case "mag":
//                    default:
//                        print("Unknown attribute: \(attributeDict)")
//                }
                
            }
            else if currentSection == "portal" {
                if currentItemID != nil {
                    if let attribute:String = attributeDict["name"], value:String = attributeDict["value"]{
                        switch attribute{
                        case "pn":
                            print("attribute: \(attribute) - \(value)")
                        case "pt":
                            print("attribute: \(attribute) - \(value)")
                        case "x":
                            print("attribute: \(attribute) - \(value)")
                        case "y":
                            print("attribute: \(attribute) - \(value)")
                        case "tm":
                            print("attribute: \(attribute) - \(value)")
                        case "tn":
                            print("attribute: \(attribute) - \(value)")
                        default:
                            print("Unknown attribute: \(attributeDict)")
                        }
                    }
                }else{
                    currentItemID = attributeDict["name"]
                }
                
            }
            else if currentSection == "info" {
                if let attribute:String = attributeDict["name"], value:String = attributeDict["value"] {
                    switch attribute {
                        case "version":
                            version = Int(value)
                        case "cloud":
                            cloud = Int(value)
                        case "town":
                            town = Int(value)
                        case "returnMap":
                            returnMap = Int(value)
                        case "mobRate":
                            mobRate = Float(value)
                        case "bgm":
                            bgm = value
                        case "mapDesc":
                            mapDesc = value
                        case "hideMinimap":
                            hideMinimap = Int(value)
                        case "forcedReturn":
                            forcedReturn = Int(value)
                        case "fieldLimit":
                            fieldLimit = Int(value)
                        case "mapMark":
                            mapMark = value
                        case "swim":
                            swim = Int(value)
                        default:
                            print("Unknown attribute: \(attributeDict)")
                    }
                }
                
            }
            else{
                if Int(currentSection!) != nil {
                    print("section: \(currentSection)")
                }else{
                    print("Unknown section: \(currentSection)")
                }
            }
        }else{
            if elementQueue.count == 1 {
                if let mapID = attributeDict["name"] {
                    print("mapID: \(mapID)")
                }
            }else if elementQueue.count == 2 {
                let section:String = attributeDict["name"]!
                currentSection = section
            }
        }
    }
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        guard elementQueue.last != elementName else {
            print("error last element not the ending Element")
            return
        }
        
        if elementQueue.last == "imgdir"{
            if currentItemID != nil {
                currentItemID = nil
            }else if currentSection != nil {
                currentSection = nil
            }
        }
        
        elementQueue.removeLast()
    }

}
