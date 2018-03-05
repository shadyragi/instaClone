//
//  Profile.swift
//  testApi
//
//  Created by shady on 12/3/17.
//  Copyright © 2017 shady. All rights reserved.
//

import Foundation


class Profile {
    
    private var _id: Int!
    
    private var _name: String!
    
    private  var _email: String!
    
    private var _followed: Bool!
    
    var id: Int {
        
        get {
            if self._id == nil {
                self._id = 0
            }
            
            return self._id
        }
        
        set {
            self._id = newValue
        }
    }
    
    var name: String {
        
        get {
            if _name == nil {
                _name = ""
            }
            
            return _name
        }
        
        set {
            _name = newValue
        }
        
    }
    
    var email: String {
        get {
        
        if _email == nil {
            _email = ""
        }
        
        return _email
        }
        
        set {
            _email = newValue
        }
    }
    
    var followed: Bool {
        
        get {
            if _followed == nil {
                _followed = false
            }
            return _followed
            
        }
        
        set {
            
            _followed = newValue
        }
    }
    
    
}
