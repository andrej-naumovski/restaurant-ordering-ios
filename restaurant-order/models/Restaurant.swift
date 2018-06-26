//
//  Restaurant.swift
//  restaurant-order
//
//  Created by Andrej Naumovski on 6/16/18.
//  Copyright © 2018 Andrej Naumovski. All rights reserved.
//

import ObjectMapper

struct Restaurant: Mappable {
    var id: String?
    var name: String?
    var tables: [TableData]?
    var menu: Menu?
    
    init() {
        
    }
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        id      <-  map["_id"]
        name    <-  map["name"]
        tables  <-  map["tables"]
        menu    <-  map["menu"]
    }
}
