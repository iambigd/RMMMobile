//
//  RESTClient.swift
//  RMM
//
//  Created by wei chih tsai on 2016/1/19.
//  Copyright © 2016年 ECG. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class RESTClient{
    
//    let applicationType ="application/json"
    
    let log =  LogSwift.logger
    
    let restHeaders = [
        "Content-Type":"application/json",
        "Accept":"application/json"
//        ,"Authorization":"Basic YWRtaW46YWRtaW4="

        
    ];
    
    init() {
//        super.init()
    }
    
//    func addHeader(){
//    
//    }
    
    func request(
            endpoint:String,
            httpMethod:String,
            inputParamter:[ String : AnyObject]? = nil,
            completionHandler:(jsonObject: JSON?, error: NSError?) -> ()){
                
                log.info("endpoint: (endpoint)");
        
                var method:Alamofire.Method?
                
                switch httpMethod{
                    case "POST":
                        method = .POST;
//                        break;
                    case "GET":
                        method = .GET;
//                        break;
                    
                    default:
                        method = .GET;
                }
            
                print(inputParamter);
                
        Alamofire.request(method!,endpoint, parameters: inputParamter,encoding: .JSON,headers: self.restHeaders)
            
            .responseJSON { response in
//                print(response.response?.statusCode)
//                print(response.request)  // original URL request
//                print(response.response) // URL response
//                print(response.data)     // server data
//                print(response.result)   // result of response serialization (optinal)
                
                self.log.debug("response:\(response.response)");
                
                switch response.result {
                case .Success(let value):
                    self.log.debug("succeed to call request");
                    
                    let convJson = SwiftyJSON.JSON(value)
                    
                    completionHandler(jsonObject: convJson as JSON, error: nil)
                    
                case .Failure(let error):
                    
                    var debugErr = response.result.value
                    
                    self.log.debug("fail to call request: \(debugErr)");
                    
                    completionHandler(jsonObject: nil, error: error)
                }
                
        }

    }
   
    
}