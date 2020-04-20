//
//  LoginUser.swift
//  NetworkSignUp
//
//  Created by 이성근 on 25/03/2020.
//  Copyright © 2020 Draw_corp. All rights reserved.
//

import Foundation

class UserInfo {
    static let shared = UserInfo()

    var info = LoginUser()

    // Prevnet NewInstancel
    private init(){
    }
}

struct LoginUser : Codable{
    let name : String?
    let password : String?
    let email : String? 
    let id : Int?

     init(){
        self.name = ""
        self.password = ""
        self.email = ""
        self.id = 0
    }
}
