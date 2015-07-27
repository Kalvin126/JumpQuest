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
    var footholds:[MapFoothold]
    var ladders:[MapLR]
    var backTiles:[MapBackTile]
    var objects:[MapObject]
    
    override init(){
        miniMap = MapMiniMap()
        tiles = []
        footholds = []
        ladders = []
        backTiles = []
        objects = []
        
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
    private var currentItemInstance:AnyObject?
    
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        elementQueue.append(elementName)
        
        if currentSection != nil {
            if currentSection == "back" {
                if currentItemID != nil {
                    if let attribute:String = attributeDict["name"], value:String = attributeDict["value"]{
                        switch attribute{
                        case "bS":
                            (currentItemInstance as! MapBackTile).bS = value
                        case "no":
                            (currentItemInstance as! MapBackTile).no = Int(value)
                        case "x":
                            (currentItemInstance as! MapBackTile).x = Int(value)
                        case "y":
                            (currentItemInstance as! MapBackTile).y = Int(value)
                        case "rx":
                            (currentItemInstance as! MapBackTile).rx = Int(value)
                        case "ry":
                            (currentItemInstance as! MapBackTile).ry = Int(value)
                        case "type":
                            (currentItemInstance as! MapBackTile).type = Int(value)
                        case "cx":
                            (currentItemInstance as! MapBackTile).cx = Int(value)
                        case "cy":
                            (currentItemInstance as! MapBackTile).cy = Int(value)
                        case "a":
                            (currentItemInstance as! MapBackTile).a = Int(value)
                        case "front":
                            (currentItemInstance as! MapBackTile).front = Int(value)
                        case "ani":
                            (currentItemInstance as! MapBackTile).ani = Int(value)
                        case "f":
                            (currentItemInstance as! MapBackTile).f = Int(value)
                        default:
                            print("Unknown attribute: \(attributeDict)")
                        }
                    }
                }else{
                    currentItemID = attributeDict["name"]
                    currentItemInstance = MapBackTile(ID: Int(currentItemID!)!)
                    backTiles += [currentItemInstance as! MapBackTile]
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
                            (currentItemInstance as! MapFoothold).x1 = Int(value)
                        case "y1":
                            (currentItemInstance as! MapFoothold).y1 = Int(value)
                        case "x2":
                            (currentItemInstance as! MapFoothold).x2 = Int(value)
                        case "y2":
                            (currentItemInstance as! MapFoothold).y2 = Int(value)
                        case "prev":
                            (currentItemInstance as! MapFoothold).prev = Int(value)
                        case "next":
                            (currentItemInstance as! MapFoothold).next = Int(value)
                        default:
                            print("Unknown attribute: \(attributeDict)")
                        }
                    }
                }else if currentSubItemID != nil {
                    currentSubSubItemID = attributeDict["name"]
                    currentItemInstance = MapFoothold()
                    footholds += [currentItemInstance as! MapFoothold]
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
                            (currentItemInstance as! MapLR).l = Int(value)
                        case "uf":
                            (currentItemInstance as! MapLR).uf = Int(value)
                        case "x":
                            (currentItemInstance as! MapLR).x = Int(value)
                        case "y1":
                            (currentItemInstance as! MapLR).y = Int(value)
                        case "y2":
                            (currentItemInstance as! MapLR).y2 = Int(value)
                        case "page":
                            (currentItemInstance as! MapLR).page = Int(value)
                        default:
                            print("Unknown attribute: \(attributeDict)")
                        }
                    }
                }else{
                    currentItemID = attributeDict["name"]
                    currentItemInstance = MapLR(ID:Int(currentItemID!)!)
                    ladders += [currentItemInstance as! MapLR]
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
                            case "no":
                                (currentItemInstance as! MapTile).no = Int(value)
                                (currentItemInstance as! MapTile).setDesignSize()
                            case "zM":
                                (currentItemInstance as! MapTile).zM = Int(value)
                            default:
                                print("Unknown attribute: \(attributeDict)")
                            }
                        }else if currentItemID == "obj" {
                            switch attribute {
                            case "oS":
                                (currentItemInstance as! MapObject).oS = value
                            case "l0":
                                (currentItemInstance as! MapObject).l0 = value
                            case "l1":
                               (currentItemInstance as! MapObject).l1 = value
                            case "l2":
                                (currentItemInstance as! MapObject).l2 = value
                            case "x":
                               (currentItemInstance as! MapObject).x = Int(value)
                            case "y":
                                (currentItemInstance as! MapObject).y = Int(value)
                            case "z":
                               (currentItemInstance as! MapObject).z = Int(value)
                            case "f":
                                (currentItemInstance as! MapObject).f = Int(value)
                            case "zM":
                                (currentItemInstance as! MapObject).zM = Int(value)
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
                                print("\(value)")
                            }
                        case "tile":
                            currentSubItemID = attribute
                            currentItemInstance = MapTile(ID:Int(currentSubItemID!)!)
                            tiles += [currentItemInstance as! MapTile]
                        case "obj":
                            currentSubItemID = attribute
                            currentItemInstance = MapObject(ID:Int(currentSubItemID!)!)
                            objects += [currentItemInstance as! MapObject]
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
        var closestTitle:MapTile?
        var closestDistance:Int = Int.max
        
        for t in tiles{
            if t === tile{
                continue
            }
            
            let dist = distance(tile.x!, tile.y!, t.x!, t.y!)
            if closestDistance > dist {
                closestTitle = t
                closestDistance = dist
            }
        }
        
        if closestDistance < 15 {
            let topParentSize = closestTitle?.design.size
            
            return (x:closestTitle!.x!, y:((closestTitle?.y!)!+topParentSize!.height))
        }
        
        return nil
    }

}
