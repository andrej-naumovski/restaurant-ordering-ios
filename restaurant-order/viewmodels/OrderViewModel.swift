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
    
    private let disposeBag = DisposeBag()
    
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
    
    func createOrder() {
        OrderService
            .createOrder(with: order.value)
            .subscribe { [weak self] response in
                print(response)
                if let response = response.element {
                    if 200...299 ~= response.status! {
                        if let order = response.payload?.order {
                            self?.order.value = order
                        }
                    }
                }
            }
            .disposed(by: disposeBag)
    }
}
