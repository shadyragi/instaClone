//
//  Post.swift
//  testApi
//
//  Created by shady on 11/28/17.
//  Copyright © 2017 shady. All rights reserved.
//

import Foundation


class Post {
    
    private var _caption: String!
    
    private var _location: String!
    
    private var _username: String!
    
    private var _likesCount: Int!
    
    private var _image: String!
    
    private var _sharedImage: String!
    
    private var _id: Int!
    
    private var _isLiked: Bool!
    
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
    
    
    var location: String {
        
        get {
            
            if _location == nil {
                _location = ""
            }
            
            return _location
            
        }
        
        set {
            _location = newValue
        }
        
    }
    
    var isLiked: Bool {
        
        get {
            if _isLiked == nil {
                _isLiked = false
            }
            
            return _isLiked
        }
        set {
            _isLiked = newValue
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
    
    var caption: String {
        
        get {
        
        if _caption == nil {
            
            _caption = ""
        }
        
        return _caption
    }
        set {
            _caption = newValue
        }
    }
    
    var username: String {
        get {
        if _username == nil {
            _username = ""
        }
        
        return _username
    }
        set {
            _username = newValue
        }
    }
    
    var likesCount: Int {
        get {
        if _likesCount == nil {
            _likesCount = 0
        }
        
        return _likesCount
    }
        set {
            _likesCount = newValue
        }
    }
    
    var sharedImage: String {
        get {
            if _sharedImage == nil {
                _sharedImage = ""
            }
            return _sharedImage
        }
        set {
            _sharedImage = newValue
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
    
    init(data: [String: AnyObject]) {
        
        self.caption = (data["caption"] as? String)!
        
        self.likesCount = 0
        
        self.id = (data["id"] as? Int)!
        
        self.username = (data["username"] as? String)!
        
        self.image = "profile"
        
        self.sharedImage = (data["image"]!) as! String
        
        self.likesCount = (data["likes_count"] as? Int)!
        
        self.isLiked = (data["isLiked"] as? Bool)!
        
        self.location = (data["location"] as? String)!
        
        self.isOwner = (data["isOwner"] as? Bool)!
    }
    
}
