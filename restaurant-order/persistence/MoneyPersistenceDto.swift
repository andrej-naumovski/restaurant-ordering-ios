//
//  MoneyPersistenceDto.swift
//  restaurant-order
//
//  Created by Andrej Naumovski on 6/26/18.
//  Copyright © 2018 Andrej Naumovski. All rights reserved.
//

import RealmSwift

class MoneyPersistenceDto: Object {
    @objc dynamic var value: String?
    @objc dynamic var currency: String?
}
