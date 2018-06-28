//
//  OrderViewController.swift
//  restaurant-order
//
//  Created by Andrej Naumovski on 6/28/18.
//  Copyright © 2018 Andrej Naumovski. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class OrderViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var orderTableView: UITableView!
    
    private let orderViewModel = OrderViewModel.shared
    
    private let disposeBag = DisposeBag()
    
    @IBOutlet weak var confirmOrderButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        orderTableView.delegate = self
        orderTableView.dataSource = self

        orderViewModel.order
            .asObservable()
            .map { !$0.isConfirmed }
            .bind(to: confirmOrderButton.rx.isEnabled)
            .disposed(by: disposeBag)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orderViewModel.order.value.items?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        let item = orderViewModel.order.value.items?[indexPath.row]
        
        let cellContent = "\(item?.name ?? "") \(item?.price?.getStringRepresentation() ?? "")"
        
        cell.textLabel?.text = cellContent
        
        return cell
    }
    
    @IBAction func onConfirmOrderClick(_ sender: Any) {
        orderViewModel.markOrderAsCompleted()
    }
    
}
