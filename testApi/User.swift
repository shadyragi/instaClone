//
//  User.swift
//  testApi
//
//  Created by shady on 12/1/17.
//  Copyright © 2017 shady. All rights reserved.
//

import Foundation


class User {
    
    static var shared = User()
    
    private init() {}
    
    
    private var _id: Int!
    
    private var _name: String!
    
    private var _email: String!
    
    var id: Int {
        get {
        if(_id == nil) {
            
            _id = 0
        }
        
        return _id
    }
        set {
            _id = newValue
        }
    }
    
    var name: String {
        get {
        if _name == nil {
            _name = ""
        }
        return  _name
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
    
    
}
