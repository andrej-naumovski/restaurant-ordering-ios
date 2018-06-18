//
//  RestaurantViewModel.swift
//  restaurant-order
//
//  Created by Andrej Naumovski on 6/18/18.
//  Copyright © 2018 Andrej Naumovski. All rights reserved.
//

import RxSwift

class RestaurantViewModel {
    let selectedRestaurant = Variable<Restaurant?>(nil)
    let restaurantList = Variable<[Restaurant]>([])
    
    let disposeBag = DisposeBag()
    
    func fetchNearestRestaurants(userLocation: LatLng) {
        RestaurantService
            .getNearestRestaurants(for: userLocation)
            .subscribe { [weak self] response in
                if let restaurantListResponse = response.event.element {
                    if let restaurantList = restaurantListResponse.message?.restaurantList {
                        self?.restaurantList.value = restaurantList
                        if restaurantList.count > 0 {
                            self?.selectedRestaurant.value = restaurantList[0]
                        }
                    }
                }
            }
            .disposed(by: disposeBag)
    }
}
