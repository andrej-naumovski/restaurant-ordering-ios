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
    var quantity: Double?
    var quantityType: String?
    var category: String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        id              <-  map["_id"]
        price           <-  map["price"]
        quantity        <-  map["quantity"]
        quantityType    <-  map["quantityType"]
        category        <-  map["category"]
    }
}
