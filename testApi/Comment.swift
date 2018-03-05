//
//  Comment.swift
//  testApi
//
//  Created by shady on 12/4/17.
//  Copyright © 2017 shady. All rights reserved.
//

import Foundation


class Comment {
    
    private var _id: Int!
    
    private var _comment: String!
    
    private var _user_id: Int!
    
    private var _post_id: Int!
    
    private var _user: Dictionary<String, AnyObject>!
    
    private var _isOwner: Bool!
    
    var isOwner: Bool {
        
        get {
            if _isOwner == nil {
                
                _isOwner = false
            }
            return _isOwner
        }
        
        set {
            
            _isOwner = newValue
        }
    }
    
    
    var user: Dictionary<String, AnyObject> {
        
        get {
            
            if _user == nil {
                
                _user = [String: AnyObject]()
            }
            return _user
        }
        
        set {
            self._user = newValue
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
    var comment: String {
        
        get {
            
            if _comment == nil {
                _comment = ""
            }
            
            return _comment
        }
        
        set {
            _comment = newValue
            
        }
        
    }
    
    var user_id: Int {
        
        get{
        
        if _user_id == nil {
            _user_id = 0
        }
        return _user_id
    }
        set {
            
            _user_id = newValue
        }
    }
    
    var post_id: Int {
        get {
            
            if _post_id == nil {
                _post_id = 0
            }
            
            return _post_id
        }
        
        set {
            _post_id = newValue
        }
    }
    
    init(commentData: [String: AnyObject]) {
        
        self.comment = (commentData["comment"] as? String)!
        
        self.id = (commentData["id"] as? Int)!
        
        self.user_id = (commentData["user_id"] as? Int)!
        
        self.post_id = (commentData["post_id"] as? Int)!
        
        self.user = (commentData["user"] as? [String: AnyObject])!
        
        self.isOwner = (commentData["isOwner"] as? Bool)!
        
    }
    
    
}
