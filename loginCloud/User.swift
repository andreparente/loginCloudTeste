//
//  User.swift
//  loginCloud
//
//  Created by Andre Machado Parente on 7/11/16.
//  Copyright © 2016 Andre Machado Parente. All rights reserved.
//

import Foundation

public var userLogged: User!
public let defaults = NSUserDefaults.standardUserDefaults()

public class User {
    
    var userID: String!
    
    init(ID: String) {
        self.userID = ID
    }

}