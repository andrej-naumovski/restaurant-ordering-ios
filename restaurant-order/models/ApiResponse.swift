//
//  ApiResponse.swift
//  restaurant-order
//
//  Created by Andrej Naumovski on 6/16/18.
//  Copyright © 2018 Andrej Naumovski. All rights reserved.
//

import ObjectMapper

struct ApiResponse<T: Mappable>: Mappable {
    var status: Int?
    var message: T?
    
    init(status: Int = 500, message: T? = nil) {
        self.status = status
        self.message = message
    }
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        status  <-  map["status"]
        message <-  map["message"]
    }
}
