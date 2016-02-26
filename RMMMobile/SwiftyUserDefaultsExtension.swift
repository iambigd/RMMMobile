//
//  DefaultsStorage.swift
//  RMM
//
//  Created by wei chih tsai on 2016/2/3.
//  Copyright © 2016年 ECG. All rights reserved.
//

import Foundation
import SwiftyUserDefaults

extension NSUserDefaults {
    subscript(key: DefaultsKey<UserModel?>) -> UserModel? {
        get { return unarchive(key) }
        set { archive(key, newValue) }
    }
}

extension DefaultsKeys {

//        static let user = DefaultsKey<String?>("user")
    static let user = DefaultsKey<UserModel?>("user")
    
}

