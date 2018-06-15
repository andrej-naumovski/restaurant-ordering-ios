//
//  TableData.swift
//  restaurant-order
//
//  Created by Andrej Naumovski on 6/5/18.
//  Copyright © 2018 Andrej Naumovski. All rights reserved.
//

struct TableData: Decodable {
    var restaurantName: String
    var tableNumber: Int
    var actionUrl: String
    
    init(restaurantName: String = "", tableNumber: Int = -1, actionUrl: String = "") {
        self.restaurantName = restaurantName
        self.tableNumber = tableNumber
        self.actionUrl = actionUrl
    }
}
