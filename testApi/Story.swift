//
//  Story.swift
//  testApi
//
//  Created by shady on 12/7/17.
//  Copyright © 2017 shady. All rights reserved.
//

import Foundation


class Story {
    
    private var _id: Int!
    
    private var _user_id: Int!
    
    private var _image: String!
    
    private var _user: [String: AnyObject]!
    
    var user: [String: AnyObject] {
        
        get {
            
            if _user == nil {
                _user = [String: AnyObject]()
            }
            
            return _user
            
        }
        
        set {
            
            _user = newValue
        }
        
    }
    
    
    var id: Int {
        
        get {
            
            if _id == nil {
                _id = 0
            }
            
            return _id
        }
        
        set {
            
            _id = newValue
        }
    }
    
    var user_id: Int {
        
        get {
            
            if _user_id == nil {
                
                _user_id = 0
            
            }
            return _user_id
            
            
        }
        
        set {
            
            _user_id = newValue
        }
        
        
    }
    
    var image: String {
        
        get {
            if _image == nil {
                
                _image = ""
            }
            return _image
        }
        
        set {
            
            _image = newValue
        }
        
    }
    
    init(storyData: [String: AnyObject]) {
        
        self.id = (storyData["id"] as? Int)!
        
        self.image = (storyData["image"] as? String)!
        
        self.user_id = (storyData["user_id"] as? Int)!
        
        self.user = (storyData["user"] as? [String: AnyObject])!
        
    }
    
    
}

