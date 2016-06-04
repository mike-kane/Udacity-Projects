//
//  JSON-Parsing-Animals-Solution.playground
//  iOS Networking
//
//  Created by Jarrod Parkes on 09/30/15.
//  Copyright (c) 2015 Udacity. All rights reserved.
//

import Foundation
import UIKit

/* Path for JSON files bundled with the Playground */
var pathForAnimalsJSON = NSBundle.mainBundle().pathForResource("animals", ofType: "json")

/* Raw JSON data (...simliar to the format you might receive from the network) */
var rawAnimalsJSON = NSData(contentsOfFile: pathForAnimalsJSON!)

/* Error object */
var parsingAnimalsError: NSError? = nil

/* Parse the data into usable form */
var parsedAnimalsJSON = try! NSJSONSerialization.JSONObjectWithData(rawAnimalsJSON!, options: .AllowFragments) as! NSDictionary

func parseJSONAsDictionary(dictionary: NSDictionary) {
    /* Start playing with JSON here... */
    
    guard let photosDictionary = dictionary["photos"] as? NSDictionary else {
        print("cannot find key 'photos'")
        return
    }
    
    guard let arrayOfDictionaries = photosDictionary["photo"] as? [[String:AnyObject]] else {
        print("can't find key 'photo'")
        return
    }
    
    guard let totalPhotoCount = photosDictionary["total"] as? Int else {
        print("cant find key 'total'")
        return
    }
    
    print(totalPhotoCount)
    
    for (index, photo) in arrayOfDictionaries.enumerate() {
        
        
        guard let commentDictionary = photo["comment"] as? [String:AnyObject] else {
            print("cant find key 'comment'")
            return
        }
        
        guard let content = commentDictionary["_content"] as? String else {
            print("cant find key '_content'")
            return
        }
        
        if content.containsString("interrufftion") {
            print(index)
        }
        
        if let urlForPhoto = photo["url_m"] as? String where index == 2 {
            let urlForPhoto = NSURL(string: urlForPhoto)
            let imageData = NSData(contentsOfURL: urlForPhoto!)
            let image = UIImage(data: imageData!)
            
            
            
            
            
        }
        
    }
    
    

}

parseJSONAsDictionary(parsedAnimalsJSON)
