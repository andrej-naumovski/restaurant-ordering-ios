//
//  LatLng.swift
//  restaurant-order
//
//  Created by Andrej Naumovski on 6/3/18.
//  Copyright © 2018 Andrej Naumovski. All rights reserved.
//

import ObjectMapper

struct LatLng: Mappable {
    var latitude: Double?
    var longitude: Double?
    
    init(latitude: Double = 0.0, longitude: Double = 0.0) {
        self.latitude = latitude
        self.longitude = longitude
    }
    
    init?(map: Map) {

    }
    
    mutating func mapping(map: Map) {
        latitude    <-  map["latitude"]
        longitude   <-  map["longitude"]
    }
    
}
