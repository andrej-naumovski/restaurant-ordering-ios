//
//  TableDataPersistenceDto.swift
//  restaurant-order
//
//  Created by Andrej Naumovski on 6/25/18.
//  Copyright © 2018 Andrej Naumovski. All rights reserved.
//

import RealmSwift

class TableDataPersistenceDto: Object {
    @objc dynamic var id: String?
    let tableNumber = RealmOptional<Int>()
}
