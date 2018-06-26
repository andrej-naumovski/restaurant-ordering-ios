//
//  MenuViewController.swift
//  restaurant-order
//
//  Created by Andrej Naumovski on 6/26/18.
//  Copyright © 2018 Andrej Naumovski. All rights reserved.
//

import UIKit
import RxSwift

class MenuViewController: UIViewController {
    private let restaurantViewModel = RestaurantViewModel.shared
    
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        restaurantViewModel.selectedRestaurant
            .asObservable()
            .subscribe { [unowned self] in
                if let restaurant = $0.element {
                    print(restaurant)
                } else {
                    self.restaurantViewModel.loadRestaurantFromRealm()
                }
            }
            .disposed(by: disposeBag)
        
    }
}
