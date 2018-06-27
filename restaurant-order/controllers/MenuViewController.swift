//
//  MenuViewController.swift
//  restaurant-order
//
//  Created by Andrej Naumovski on 6/26/18.
//  Copyright © 2018 Andrej Naumovski. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class MenuViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var menuTable: UITableView!
    @IBOutlet weak var createOrderButton: UIBarButtonItem!
    
    private let restaurantViewModel = RestaurantViewModel.shared
    private let orderViewModel = OrderViewModel.shared
    private let tableViewModel = TableViewModel.shared
    
    private var restaurant: Restaurant?
    
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuTable.dataSource = self
        menuTable.delegate = self
        
        let isOrderNotCreatedObservable = orderViewModel.order
            .asObservable()
            .map { $0.id == nil }
        
        isOrderNotCreatedObservable
            .bind(to: createOrderButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        tableViewModel.loadTableDataFromRealm()
        
        tableViewModel.tableId
            .asObservable()
            .subscribe { [unowned self] in
                if let tableId = $0.element {
                    self.orderViewModel.updateOrderTableId(tableId)
                } else {
                    self.tableViewModel.loadTableDataFromRealm()
                }
            }
            .disposed(by: disposeBag)

        restaurantViewModel.selectedRestaurant
            .asObservable()
            .subscribe { [unowned self] in
                if let restaurant = $0.element {
                    self.restaurant = restaurant
                    self.orderViewModel.updateOrderRestaurantId(restaurant?.id)
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let menuItem = restaurant?.menu?.categories?[indexPath.section].items?[indexPath.row] {
            orderViewModel.addItemToOrder(withId: menuItem.id, andCategory: menuItem.category)
        }
    }
}
