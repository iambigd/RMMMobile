//
//  AuthService.swift
//  RMM
//
//  Created by wei chih tsai on 2016/1/19.
//  Copyright © 2016年 ECG. All rights reserved.
//

import Foundation
import SwiftyJSON


class AuthService{
    
    let log =  LogSwift.logger
    
    let rest = RESTClient()
    
    let apiModule:String = "AccountMgmt"
    
    init() {
//        super.init()
        log.debug("init")
    }
    
    func isAvaliable()->(){
       
        var loginAPI = ServerConfig.serverEndpoint
        //                print(loginAPI);
        var loginMethod  =  apiModule + "/2"
//                print(loginMethod);
        var fullAPI = loginAPI + loginMethod
        
//        "\(loginAPI)\(loginMethod)"

        print("isAvaliable: \(fullAPI)");
        
        
        rest.request(
//            "http://172.22.12.111:8080/webresources/AccountMgmt/2",
            fullAPI,
            httpMethod: "GET",
            inputParamter: nil,
            completionHandler: {
                (jsonObject,error) in
                
                self.log.debug("complete to call account mgmt for admin")
                //
                self.log.debug("JSON = \(jsonObject); error = \(error)")
                
                
        })
        
    }
    
    
    func login(username:String,password:String,completionHandler:(userModel: UserModel?, error: NSError?) -> ()){
        /*
        {
        "request" :
        { "item" : [ { "@name" : "username",
        "@value" : "admin"
        },
        { "@name" : "password",
        "@value" : "adminadmin"
        }
        ]
        }
        }
        */
        
        var loginAPI = ServerConfig.serverEndpoint
//        print("loginAPI:" + loginAPI);
        var loginMethod  =  apiModule + "/login"
//        print("loginMethod:" + loginMethod);
        var fullAPI = "\(loginAPI)\(loginMethod)"
        print(fullAPI)
        
        
        var postbody : [ String : AnyObject]  = [
            "request":[
                "item":[
                    ["@name":  "username","@value": username],
                    ["@name":  "password","@value": password]
                   ]
            ]
        ]
        
        
        rest.request(
            fullAPI,
            httpMethod: "POST",
            inputParamter: postbody,
            completionHandler: {
                (jsonObject,error) in
//                
                self.log.debug("complete to call login api")
//
                self.log.debug("JSON = \(jsonObject); error = \(error)")
                
                let userModel = UserModel()
                
                let authToken = "Basic " + self.generateToken(username, password: password)
                
                //需加!
                var result = jsonObject!["result"]
                
                let accountId = result["role"]["account"]["@id"].string
                let active = result["role"]["active"].bool
                let tag = result["role"]["tag"].array
                
                self.log.debug("JSON = \(tag);");
                
                
                userModel.setAccountId(accountId!)
                userModel.setName(username)
                userModel.setActive(active!)
//                userModel.setTag(tag)
                userModel.setToken(authToken)
                
                
                completionHandler(userModel: userModel, error: error)
//                let errorCode = jsonObject["result"]["ErrorCode"] as! Int
                
                
        })
    }
    
    
    func generateToken(username:String,password:String)->String{
        
        log.info("generateToken");
        
        let authToken = username + ":" + password
        
        let utf8str = authToken.dataUsingEncoding(NSUTF8StringEncoding)
        
        let base64Encoded = utf8str?.base64EncodedStringWithOptions(NSDataBase64EncodingOptions(rawValue: 0))
        
        log.debug("Encoded:  \(base64Encoded)")
        
        return base64Encoded!
    }
}
