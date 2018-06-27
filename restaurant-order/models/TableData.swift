//
//  TableData.swift
//  restaurant-order
//
//  Created by Andrej Naumovski on 6/19/18.
//  Copyright © 2018 Andrej Naumovski. All rights reserved.
//

import ObjectMapper

struct TableData: Mappable {
    var id: String?
    var tableNumber: Int?
    var isAvailable: Bool?
    var employeeId: String?
    
    init() {
        
    }
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        id          <-  map["_id"]
        tableNumber <-  map["tableNumber"]
        isAvailable <-  map["isAvailable"]
        employeeId  <-  map["employeeId"]
    }
}
