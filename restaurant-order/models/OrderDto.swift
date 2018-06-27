//
//  OrderDto.swift
//  restaurant-order
//
//  Created by Andrej Naumovski on 6/27/18.
//  Copyright © 2018 Andrej Naumovski. All rights reserved.
//

import ObjectMapper

struct OrderDto: Mappable {
    var order: Order?
    
    init() {
        
    }
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        order   <-  map["order"]
    }
}
