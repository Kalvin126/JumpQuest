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
    
    var mapID:Int?
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
    
    var miniMap:MapMiniMap?
    var tiles:[MapTile]
    
    override init(){
        miniMap = MapMiniMap()
        tiles = []
        
        super.init()
        
        let path = NSBundle.mainBundle().pathForResource("101000100", ofType: "xml")
        let mapData = NSData(contentsOfFile: path!)
        
        let parser = NSXMLParser(data: mapData!)
        parser.delegate = self
        parser.parse()
        
    }
    
    private var currentSection:String?
    private var currentItemID:String?
    private var currentSubItemID:String?
    private var currentSubSubItemID:String?
    private var currentItemInstance:MapItem?
    
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
                if currentSubSubItemID != nil {
                    if let attribute:String = attributeDict["name"], value:String = attributeDict["value"]{
                        switch attribute{
                        case "x1":
                            print("attribute: \(attribute) - \(value)")
                        case "y1":
                            print("attribute: \(attribute) - \(value)")
                        case "x2":
                            print("attribute: \(attribute) - \(value)")
                        case "y2":
                            print("attribute: \(attribute) - \(value)")
                        case "prev":
                            print("attribute: \(attribute) - \(value)")
                        case "next":
                            print("attribute: \(attribute) - \(value)")
                        default:
                            print("Unknown attribute: \(attributeDict)")
                        }
                    }
                }else if currentSubItemID != nil {
                    currentSubSubItemID = attributeDict["name"]
                }else if currentItemID != nil {
                    currentSubItemID = attributeDict["name"]
                }else{
                    currentItemID = attributeDict["name"]
                }
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
                let value:String? = attributeDict["value"]
                
                switch attributeDict["name"]! {
                case "canvas":
                    miniMap?.baseData = baseData
                case "width":
                    miniMap?.width = Int(value!)
                case "height":
                    miniMap?.height = Int(value!)
                case "centerX":
                    miniMap?.centerX = Int(value!)
                case "centerY":
                    miniMap?.centerY = Int(value!)
                case "mag":
                    miniMap?.mag = Int(value!)
                default:
                    print("Unknown attribute: \(attributeDict)")
                }
                
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
            else if Int(currentSection!) != nil {           // Tile section
                if currentSubItemID != nil {
                    if let attribute:String = attributeDict["name"], value:String = attributeDict["value"]{
                        if currentItemID == "tile" {
                            switch attribute {
                            case "x":
                                (currentItemInstance as! MapTile).x = Int(value)
                            case "y":
                                (currentItemInstance as! MapTile).y = Int(value)
                            case "u":
                                (currentItemInstance as! MapTile).u = value
                                (currentItemInstance as! MapTile).setDesign(value)
                            case "no":
                                (currentItemInstance as! MapTile).no = Int(value)
                            case "zM":
                                (currentItemInstance as! MapTile).zM = Int(value)
                            default:
                                print("Unknown attribute: \(attributeDict)")
                            }
                        }else if currentItemID == "obj" {
                            switch attribute {
                            case "oS":
                                print("attribute: \(attribute) - \(value)")
                            case "l0":
                                print("attribute: \(attribute) - \(value)")
                            case "l1":
                                print("attribute: \(attribute) - \(value)")
                            case "l2":
                                print("attribute: \(attribute) - \(value)")
                            case "x":
                                print("attribute: \(attribute) - \(value)")
                            case "y":
                                print("attribute: \(attribute) - \(value)")
                            case "z":
                                print("attribute: \(attribute) - \(value)")
                            case "f":
                                print("attribute: \(attribute) - \(value)")
                            case "zM":
                                print("attribute: \(attribute) - \(value)")
                            default:
                                print("Unknown attribute: \(attributeDict)")
                            }
                        }
                    }
                }else if currentItemID != nil {
                    if let attribute:String = attributeDict["name"], value:String? = attributeDict["value"]{
                        switch currentItemID!{
                        case "info":
                            if attribute == "tS" {
                                // = value
                            }
                        case "tile":
                            currentSubItemID = attribute
                            currentItemInstance = MapTile(ID:Int(currentSubItemID!)!)
                            tiles += [currentItemInstance as! MapTile]
                        case "obj":
                            currentSubItemID = attribute
                        default:
                            print("Unknown attribute: \(attributeDict)")
                        }
                    }
                }else{
                    currentItemID = attributeDict["name"]
                }
            }
            else{
                print("Unknown section: \(currentSection)")
            }
        }else{
            if elementQueue.count == 1 {
                if let cMapID = attributeDict["name"] {
                    print("mapID: \(cMapID)")
                    self.mapID = Int(cMapID.substringWithRange(Range<String.Index>(start:cMapID.startIndex, end:advance(cMapID.endIndex, -4))))
                }
            }else if elementQueue.count == 2 {
                let section:String = attributeDict["name"]!
                currentSection = section
            }
        }
    }
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        guard elementQueue.last == elementName else {
            print("error last element not the ending Element")
            return
        }
        
        if elementQueue.last == "imgdir"{
            if currentSubSubItemID != nil {
                currentSubSubItemID = nil
            }else if currentSubItemID != nil {
                currentSubItemID = nil
            }else if currentItemID != nil {
                currentItemID = nil
            }else if currentSection != nil {
                currentSection = nil
            }
            
            currentItemInstance = nil
        }
        
        elementQueue.removeLast()
        
        if elementQueue.count == 0 {
            print("DONE: XMLParse of MapID: \(mapID!)")
        }
    }
    
    func getTileDesignPosition(tile:MapTile) -> (x:Int, y:Int)? {
        var multi:Int? = miniMap?.mag
        if multi == 0 {
            multi = 1
        }
        
        for t in tiles{
            if let pos = t.design?.getMath(tile.u!, x: tile.x!, y: tile.y!, multi: multi!) {
                return pos
            }
        }
        
        return nil
    }

}
