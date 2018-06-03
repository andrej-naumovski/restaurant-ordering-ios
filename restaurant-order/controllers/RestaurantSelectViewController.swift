//
//  RestaurantSelectViewController.swift
//  restaurant-order
//
//  Created by Andrej Naumovski on 6/3/18.
//  Copyright © 2018 Andrej Naumovski. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class RestaurantSelectViewController: UIViewController {
    @IBOutlet weak var scanQrCodeButton: UIButton!
    
    private let locationViewModel = LocationViewModel()
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // QR Code button additional style
        scanQrCodeButton.layer.cornerRadius = scanQrCodeButton.bounds.height * 0.5
        
        // Initiate fetching of location
        locationViewModel.updateUserLocation()
        
        // Subscribe to changes of latLng
        locationViewModel.latLng
            .asObservable()
            .observeOn(MainScheduler.instance)
            .subscribe() {
                if let latLng = $0.element! {
                    print(latLng)
                }
            }
            .disposed(by: disposeBag)
    }
}
