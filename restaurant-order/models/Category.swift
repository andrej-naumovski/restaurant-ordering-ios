//
//  Category.swift
//  restaurant-order
//
//  Created by Andrej Naumovski on 6/26/18.
//  Copyright © 2018 Andrej Naumovski. All rights reserved.
//

import ObjectMapper

struct Category: Mappable {
    var id: String?
    var name: String?
    var items: [MenuItem]?
    
    init() {
        
    }
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        id      <-  map["_id"]
        name    <-  map["name"]
        items   <-  map["items"]
    }
}
