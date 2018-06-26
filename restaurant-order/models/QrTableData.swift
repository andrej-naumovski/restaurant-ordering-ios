//
//  TableData.swift
//  restaurant-order
//
//  Created by Andrej Naumovski on 6/5/18.
//  Copyright © 2018 Andrej Naumovski. All rights reserved.
//

import ObjectMapper

struct QrTableData: Mappable {
    var id: String?
    var restaurantName: String?
    var tableNumber: Int?
    var isAvailable: Bool?
    
    init(id: String = "", restaurantName: String = "", tableNumber: Int = -1, isAvailable: Bool = true) {
        self.id = id
        self.restaurantName = restaurantName
        self.tableNumber = tableNumber
        self.isAvailable = isAvailable
    }

    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        id              <-  map["id"]
        restaurantName  <-  map["restaurantName"]
        tableNumber     <-  map["tableNumber"]
        isAvailable     <-  map["isAvailable"]
    }
}
