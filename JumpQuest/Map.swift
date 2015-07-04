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
    
    var currentSection:String?
    var currentItemID:String?
    
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        elementQueue.append(elementName)
        
        if currentSection != nil {
            switch currentSection!{
                
            case "back":
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
                
            case "life":
                print("section: \(currentSection)")
                
            case "reactor":
                print("section: \(currentSection)")
                
            case "foothold":
                print("section: \(currentSection)")
                
            case "ladderRope":
                print("section: \(currentSection)")
                
            case "miniMap":
                print("section: \(currentSection)")
                
            case "portal":
                print("section: \(currentSection)")
                
            case "info":
                print("section: \(currentSection)")
                
            default:
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
        if elementQueue.last != elementName {
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
