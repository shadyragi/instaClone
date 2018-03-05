//
//  Notification.swift
//  testApi
//
//  Created by shady on 12/10/17.
//  Copyright © 2017 shady. All rights reserved.
//

import Foundation


class Notification {
    
    private var _post: [String: AnyObject]!
    
    private var _message: String!
    
    var post: [String: AnyObject] {
        
        get {
            
            if _post == nil {
                
                _post = [String: AnyObject]()
            }
            
            return _post
            
        }
        
        set {
            
            _post = newValue
        }
        
    }
    
    var message: String {
        
        get {
            
            if _message == nil {
                
                _message = ""
            }
            
            return _message
            
        }
        
        set {
            
            _message = newValue
        }
        
    }
    
    
}
