//
//  MenuItem.swift
//  restaurant-order
//
//  Created by Andrej Naumovski on 6/26/18.
//  Copyright © 2018 Andrej Naumovski. All rights reserved.
//

import ObjectMapper

struct MenuItem: Mappable {
    var id: String?
    var price: Money?
    var name: String?
    var quantity: Double?
    var quantityType: String?
    var category: String?
    
    init() {
        
    }
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        id              <-  map["_id"]
        price           <-  map["price"]
        name            <-  map["name"]
        quantity        <-  map["quantity"]
        quantityType    <-  map["quantityType"]
        category        <-  map["category"]
    }
}
