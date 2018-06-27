//
//  MenuViewController.swift
//  restaurant-order
//
//  Created by Andrej Naumovski on 6/26/18.
//  Copyright © 2018 Andrej Naumovski. All rights reserved.
//

import UIKit
import RxSwift

class MenuViewController: UIViewController, UITableViewDataSource {
    @IBOutlet weak var menuTable: UITableView!
    
    private let restaurantViewModel = RestaurantViewModel.shared
    
    private var restaurant: Restaurant?
    
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuTable.dataSource = self

        restaurantViewModel.selectedRestaurant
            .asObservable()
            .subscribe { [unowned self] in
                if let restaurant = $0.element {
                    self.restaurant = restaurant
                } else {
                    self.restaurantViewModel.loadRestaurantFromRealm()
                }
            }
            .disposed(by: disposeBag)
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return restaurant?.menu?.categories?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurant?.menu?.categories?[section].items?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        cell.textLabel?.text = restaurant?.menu?.categories?[indexPath.section].items?[indexPath.row].name ?? ""
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return restaurant?.menu?.categories?[section].name ?? ""
    }
}
