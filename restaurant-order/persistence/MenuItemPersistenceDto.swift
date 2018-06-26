//
//  MenuItemPersistenceDto.swift
//  restaurant-order
//
//  Created by Andrej Naumovski on 6/26/18.
//  Copyright © 2018 Andrej Naumovski. All rights reserved.
//

import RealmSwift

class MenuItemPersistenceDto: Object {
    @objc dynamic var id: String?
    @objc dynamic var name: String?
    @objc dynamic var price: MoneyPersistenceDto?
    let quantity = RealmOptional<Double>()
    @objc dynamic var quantityType: String?
    @objc dynamic var category: String?
}
