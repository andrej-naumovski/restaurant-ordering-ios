//
//  TableViewModel.swift
//  restaurant-order
//
//  Created by Andrej Naumovski on 6/27/18.
//  Copyright © 2018 Andrej Naumovski. All rights reserved.
//

import RxSwift

class TableViewModel {
    static let shared = TableViewModel()
    
    var tableId = Variable<String?>(nil)
    
    private init() {
        
    }
    
    func loadTableDataFromRealm() {
        if let tableDataPersistenceDto = RestaurantPersistenceService.loadTableDataFromRealm() {
            tableId.value = tableDataPersistenceDto.id
        }
    }
}
