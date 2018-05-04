//
//  Error+IsOffline.swift
//  ios-alamofire-swifttask-demo
//
//  Created by OkuderaYuki on 2018/05/04.
//  Copyright © 2018年 OkuderaYuki. All rights reserved.
//

import Foundation

extension Error {
    
    var isOffline: Bool {
        return (self as NSError).domain == NSURLErrorDomain && (self as NSError).code == NSURLErrorNotConnectedToInternet
    }
}
