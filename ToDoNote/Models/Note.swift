//
//  Note.swift
//  ToDoNote
//
//  Created by gaetan on 29/11/2018.
//  Copyright © 2018 gaetan. All rights reserved.
//

import UIKit

class Note: NSObject {
    var title : String
    var text : String
    
    init (title : String, text: String)
    {
        self.title = title
        self.text = text
    }
    
    func encodeWithCoder(aCoder: NSCoder)
    {
        aCoder.encode(title, forKey:"title")
        aCoder.encode(text, forKey:"text")
    }
    
    init (coder aDecoder: NSCoder)
    {
        self.title = aDecoder.decodeObject(forKey: "title") as! String
        self.text = aDecoder.decodeObject(forKey: "text") as! String
    }
}
