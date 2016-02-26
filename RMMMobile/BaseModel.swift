//
//  ErrorResult.swift
//  RMM
//
//  Created by wei chih tsai on 2016/2/2.
//  Copyright © 2016年 ECG. All rights reserved.
//

import Foundation
//{
//    "result" : {
//        "Field" : "password",
//        "Description" : "Account Verification Failed",
//        "FieldValue" : "admin111",
//        "ErrorCode" : 1305
//    }
//}

class BaseModel {
    
    let log =  LogSwift.logger
    
    var field: String?
    var description: String?
    var fieldValue: String?
    var errorCode: Int64?
    
    init(){
        log.debug("init BaseModel");
    }
}