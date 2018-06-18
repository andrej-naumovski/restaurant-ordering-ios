//
//  RestaurantListDto.swift
//  restaurant-order
//
//  Created by Andrej Naumovski on 6/18/18.
//  Copyright © 2018 Andrej Naumovski. All rights reserved.
//

import ObjectMapper

struct RestaurantListDto: Mappable {
    var restaurantList: [Restaurant]?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        restaurantList  <-  map["restaurantList"]
    }
    
}
