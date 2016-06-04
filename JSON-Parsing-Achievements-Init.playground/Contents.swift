//
//  JSON-Parsing-Achievements-Solution.playground
//  iOS Networking
//
//  Created by Jarrod Parkes on 09/30/15.
//  Copyright (c) 2015 Udacity. All rights reserved.
//

import Foundation

/* Path for JSON files bundled with the Playground */
var pathForAchievementsJSON = NSBundle.mainBundle().pathForResource("achievements", ofType: "json")

/* Raw JSON data (...simliar to the format you might receive from the network) */
var rawAchievementsJSON = NSData(contentsOfFile: pathForAchievementsJSON!)

/* Error object */
var parsingAchivementsError: NSError? = nil

/* Parse the data into usable form */
var parsedAchievementsJSON = try! NSJSONSerialization.JSONObjectWithData(rawAchievementsJSON!, options: .AllowFragments) as! NSDictionary

func parseJSONAsDictionary(dictionary: NSDictionary) {
    /* Start playing with JSON here... */
    
    var matchmakingIDs = [Int]()
    var pointTotal: Double = 0.0
    var totalMatchmakingAchievements = 0
    var achievementsGreaterThan10 = 0
    
    guard let categoriesDictionary = dictionary["categories"] as? [NSDictionary] else {
        print("cant access 'categories'")
        return
    }
    
    guard let achievementsDictionary = dictionary["achievements"] as? [NSDictionary] else {
        print("cant access achievements")
        return
    }
    
    for category in categoriesDictionary {
        
        if let title = category["title"] as? String where title == "Matchmaking" {
            
            guard let children = category["children"] as? [NSDictionary] else {
                print("can't access children key")
                return
            }
            
            for child in children {
                
                guard let id = child["categoryId"] as? Int else {
                    print("can't find categoryId")
                    return
                }
                
                matchmakingIDs.append(id)
            }
            
        }
    }
    
    for achievement in achievementsDictionary {
        
        guard let points = achievement["points"] as? Int else {
            print("can't access points")
            return
        }
        
        guard let categoryID = achievement["categoryId"] as? Int else {
            print("can't access categoryId")
            return
        }
        
        guard let title = achievement["title"] as? String else {
            print("cant access title")
            return
        }
        
        guard let description = achievement["description"] as? String else {
            print("can't access description")
            return
        }
        
        if title == "Cool Running" {
            print(description)
        }
        
        if matchmakingIDs.contains(categoryID) {
            totalMatchmakingAchievements += 1
        }
        
        
        
        pointTotal += Double(points)
        
        if points > 10 {
            achievementsGreaterThan10 += 1
        }
        
        
        
        
        
    }
    
    print(pointTotal / 737.0)
    
}

parseJSONAsDictionary(parsedAchievementsJSON)
