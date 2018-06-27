//
//  OrderViewModel.swift
//  restaurant-order
//
//  Created by Andrej Naumovski on 6/27/18.
//  Copyright © 2018 Andrej Naumovski. All rights reserved.
//

import RxSwift

class OrderViewModel {
    static let shared = OrderViewModel()
    
    var order = Variable<Order>(Order())
    
    private init() {
        
    }
    
    func updateOrderRestaurantId(_ id: String?) {
        order.value.restaurantId = id
    }
    
    func updateOrderTableId(_ id: String?) {
        order.value.tableId = id
    }
    
    func addItemToOrder(withId id: String?, andCategory category: String?) {
        var orderItem = OrderItem()
        orderItem.category = category
        orderItem.id = id
        
        order.value.items?.append(orderItem)
    }
}
