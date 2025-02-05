//
//  Money.swift
//  restaurant-order
//
//  Created by Andrej Naumovski on 6/26/18.
//  Copyright © 2018 Andrej Naumovski. All rights reserved.
//

import ObjectMapper

struct Money: Mappable {
    var value: String?
    var currency: String?
    
    init() {
        
    }
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        value       <-  map["value"]
        currency    <-  map["currency"]
    }
    
    func getStringRepresentation() -> String {
        return "\(value ?? "") \(currency ?? "")"
    }
}
