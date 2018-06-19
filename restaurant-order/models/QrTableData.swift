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
    var actionUrl: String?
    
    init(id: String = "", restaurantName: String = "", tableNumber: Int = -1, actionUrl: String = "") {
        self.id = id
        self.restaurantName = restaurantName
        self.tableNumber = tableNumber
        self.actionUrl = actionUrl
    }

    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        id              <-  map["id"]
        restaurantName  <-  map["restaurantName"]
        tableNumber     <-  map["tableNumber"]
        actionUrl       <-  map["actionUrl"]
    }
}
