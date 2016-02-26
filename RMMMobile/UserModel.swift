//
//  UserModel.swift
//  RMM
//
//  Created by wei chih tsai on 2016/1/21.
//  Copyright © 2016年 ECG. All rights reserved.
//

import Foundation

class UserModel: BaseModel {
    
  
    var name:String?
    var accountId:String?
    var active:Bool?
    var tag:[String]?
 
    var token:String?
//    
//    init(accountId:Int64,name:String,active:Bool,tag:Array<String>,token:String){
//        self.accountId = accountId
//        self.name = name
//        self.active = active
//        self.tag = tag
//        self.token = token
//    }
    
    func setToken(token:String){
        self.token = token
    }
    
    func getToken()->String{
        return self.token!
    }
    
    func setName(name:String){
       self.name = name
    }
    
    func getName()->String{
        return self.name!
    }
    
    func setAccountId(accountId:String){
        self.accountId = accountId
    }
    
    func setActive(active:Bool){
        self.active = active
    }
    
    func setTag(tag:[String]){
        self.tag = tag
    }
    
    
}