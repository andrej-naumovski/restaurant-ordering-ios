//
//  RestaurantPersistenceDto.swift
//  restaurant-order
//
//  Created by Andrej Naumovski on 6/26/18.
//  Copyright © 2018 Andrej Naumovski. All rights reserved.
//

import RealmSwift

class RestaurantPersistenceDto: Object {
    @objc dynamic var id: String?
    @objc dynamic var menu: MenuPersistenceDto?
}
