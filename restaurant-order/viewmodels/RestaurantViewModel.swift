//
//  RestaurantViewModel.swift
//  restaurant-order
//
//  Created by Andrej Naumovski on 6/18/18.
//  Copyright © 2018 Andrej Naumovski. All rights reserved.
//

import RxSwift


class RestaurantViewModel {
    static let shared = RestaurantViewModel()
    
    let selectedRestaurant = Variable<Restaurant?>(nil)
    let restaurantList = Variable<[Restaurant]>([])
    let hasRestaurants = Variable<Bool>(false)
    
    private init() {
        
    }
    
    let disposeBag = DisposeBag()
    
    func fetchNearestRestaurants(userLocation: LatLng) {
        RestaurantService
            .getNearestRestaurants(for: userLocation)
            .subscribe { [weak self] response in
                if let restaurantListResponse = response.event.element {
                    if let restaurantList = restaurantListResponse.payload?.restaurantList {
                        self?.restaurantList.value = restaurantList
                        if restaurantList.count > 0 {
                            self?.selectedRestaurant.value = restaurantList[0]
                            self?.hasRestaurants.value = true
                        } else {
                            self?.hasRestaurants.value = false
                        }
                    }
                }
            }
            .disposed(by: disposeBag)
    }
    
    func persistRestaurantToRealm(_ restaurant: Restaurant) {
        let restaurantPersistenceDto = RestaurantPersistenceMapper.toPersistenceDto(from: restaurant)
        
        RestaurantPersistenceService.persistRestaurantDataToRealm(restaurantPersistenceDto)
    }
    
    func loadRestaurantFromRealm() {
        let restaurantPersistenceDto = RestaurantPersistenceService.loadRestaurantDataFromRealm()

        selectedRestaurant.value = RestaurantPersistenceMapper.toDomainModel(from: restaurantPersistenceDto)
    }
    
}
