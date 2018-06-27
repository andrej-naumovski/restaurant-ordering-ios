//
//  Order.swift
//  restaurant-order
//
//  Created by Andrej Naumovski on 6/27/18.
//  Copyright © 2018 Andrej Naumovski. All rights reserved.
//

import ObjectMapper

struct Order: Mappable {
    var id: String?
    var restaurantId: String?
    var tableId: String?
    var items: [OrderItem]? = []
    var totalValue: Money?
    
    init() {
        
    }
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        id              <-  map["_id"]
        restaurantId    <-  map["restaurantId"]
        tableId         <-  map["tableId"]
        items           <-  map["items"]
        totalValue      <-  map["totalValue"]
    }
}
