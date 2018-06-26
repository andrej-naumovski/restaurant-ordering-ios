//
//  Menu.swift
//  restaurant-order
//
//  Created by Andrej Naumovski on 6/26/18.
//  Copyright © 2018 Andrej Naumovski. All rights reserved.
//

import ObjectMapper

struct Menu: Mappable {
    var id: String?
    var categories: [Category]?
    
    init() {
        
    }
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        id          <-  map["_id"]
        categories  <-  map["categories"]
    }
}
