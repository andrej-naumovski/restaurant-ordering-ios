//
//  OrderItem.swift
//  restaurant-order
//
//  Created by Andrej Naumovski on 6/27/18.
//  Copyright © 2018 Andrej Naumovski. All rights reserved.
//

import ObjectMapper

struct OrderItem: Mappable {
    var id: String?
    var category: String?
    var name: String?
    var price: Money?
    
    init() {
        
    }
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        id          <-  map["_id"]
        category    <-  map["category"]
        name        <-  map["name"]
        price       <-  map["price"]
    }
}
