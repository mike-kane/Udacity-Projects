//
//  JSON-Parsing-Hearthstone-Solution.playground
//  iOS Networking
//
//  Created by Jarrod Parkes on 09/30/15.
//  Copyright (c) 2015 Udacity. All rights reserved.
//

import Foundation

/* Path for JSON files bundled with the Playground */
var pathForHearthstoneJSON = NSBundle.mainBundle().pathForResource("hearthstone_basic_set", ofType: "json")

/* Raw JSON data (...simliar to the format you might receive from the network) */
var rawHearthstoneJSON = NSData(contentsOfFile: pathForHearthstoneJSON!)

/* Error object */
var parsingHearthstoneError: NSError? = nil

/* Parse the data into usable form */
var parsedHearthstoneJSON = try! NSJSONSerialization.JSONObjectWithData(rawHearthstoneJSON!, options: .AllowFragments) as! NSDictionary

func parseJSONAsDictionary(dictionary: NSDictionary) {
    /* Start playing with JSON here... */
    
    guard let arrayOfDictionaries = dictionary["Basic"] as? [[String:AnyObject]] else {
        print("can't find key 'basic'")
        return
    }
    
        var totalCommonMinions = 0
        var runningCostOfCommonMinions = 0
        var minionWithCostOf5 = 0
        var weaponWithDurabilityOf2 = 0
        var minionsWithBattleCry = 0
        var statsToCostRatio = [Double]()
        var avgStatsToCostRatio: Double = 0.0
    
        for cardDictionary in arrayOfDictionaries {
        
            guard let cardType = cardDictionary["type"] as? String else {
                print("can't access 'type' in \(cardDictionary)")
                return
            }
        
            if cardType == "Minion" {
                
                guard let cost = cardDictionary["cost"] as? Int else {
                    print("cant access cost for card \(cardDictionary)")
                    return
                }
                
                guard let rarity = cardDictionary["rarity"] as? String else {
                    print("can't access rarity for card \(cardDictionary)")
                    return
                }
                
                guard let health = cardDictionary["health"] as? Int else {
                    print("can't access health for \(cardDictionary)")
                    return
                }
                
                guard let attack = cardDictionary["attack"] as? Int else {
                    print("can't access attack for \(cardDictionary)")
                    return
                }
                
                if let text = cardDictionary["text"] as? String where text.rangeOfString("Battlecry") != nil {
                    minionsWithBattleCry += 1
                }
                
                if rarity == "Common" {
                    totalCommonMinions += 1
                    runningCostOfCommonMinions += cost
                }
                
                if cost == 5 {
                    minionWithCostOf5 += 1
                }
                
                if cost != 0 {
                    var ratio: Double = Double(attack + health) / Double(cost)
                    statsToCostRatio.append(ratio)
                }
                
            }
            
            
            if cardType == "Weapon" {
                
                guard let durability = cardDictionary["durability"] as? Int else {
                    print("weapon \(cardDictionary) has no durability")
                    return
                }
                if durability == 2 {
                    weaponWithDurabilityOf2 += 1
                }
            }
        }
    
        var avgCostOfCommonMinions: Double = Double(runningCostOfCommonMinions) / Double(totalCommonMinions)
    
        for avg in statsToCostRatio {
            avgStatsToCostRatio += avg
        }
    
        avgStatsToCostRatio = avgStatsToCostRatio / Double(statsToCostRatio.count)
    
        
    }


parseJSONAsDictionary(parsedHearthstoneJSON)
