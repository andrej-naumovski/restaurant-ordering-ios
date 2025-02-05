//
//  RestaurantPersistenceService.swift
//  restaurant-order
//
//  Created by Andrej Naumovski on 6/25/18.
//  Copyright © 2018 Andrej Naumovski. All rights reserved.
//

import RealmSwift

class RestaurantPersistenceService {
    static func persistTableDataToRealm(_ tableData: TableDataPersistenceDto) {
        clearTableDataFromRealm()
        
        let realm = try! Realm()
        
        try! realm.write {
            realm.add(tableData)
        }
    }
    
    static func clearTableDataFromRealm() {
        let realm = try! Realm()
        
        let tableData = realm.objects(TableDataPersistenceDto.self)
        
        if tableData.count > 0 {
            try! realm.write {
                realm.delete(tableData)
            }
        }
    }
    
    static func persistRestaurantDataToRealm(_ restaurant: RestaurantPersistenceDto) {
        clearRestaurantDataFromRealm()
        
        let realm = try! Realm()
        
        try! realm.write {
            realm.add(restaurant)
        }
    }
    
    static func clearRestaurantDataFromRealm() {
        let realm = try! Realm()
        
        let restaurantObjects = realm.objects(RestaurantPersistenceDto.self)
        
        if restaurantObjects.count > 0 {
            try! realm.write {
                realm.delete(restaurantObjects)
            }
        }
    }
    
    static func loadRestaurantDataFromRealm() -> RestaurantPersistenceDto? {
        let realm = try! Realm()
        
        let restaurantObjects = realm.objects(RestaurantPersistenceDto.self)
        
        return restaurantObjects.first
    }
    
    static func loadTableDataFromRealm() -> TableDataPersistenceDto? {
        let realm = try! Realm()
        
        let tableData = realm.objects(TableDataPersistenceDto.self)
        
        return tableData.first
    }
}
