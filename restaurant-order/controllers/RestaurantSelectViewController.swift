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
                    //TODO andrej-naumovski 03.06.2018: Add functionality for fetching user location here
                    print(latLng)
                }
            }
            .disposed(by: disposeBag)
        
        // Handle denied permission
        locationViewModel.isPermissionDenied
            .asObservable()
            .subscribe() { [unowned self] isPermissionDenied in
                if isPermissionDenied.element! {
                    DispatchQueue.main.async {
                        self.showPermissionDeniedAlert()
                    }
                }
            }
            .disposed(by: disposeBag)
    }
    
    @IBAction func onRefreshLocationClick(_ sender: Any) {
        locationViewModel.updateUserLocation()
    }
    
    private func showPermissionDeniedAlert() {
        let alert = UIAlertController(title: "Location permission denied", message: "The application requires your location to work.", preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "Go to Settings", style: UIAlertActionStyle.default, handler: { [unowned self] _ in
            self.openSettingsOnDeniedPermission()
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    private func openSettingsOnDeniedPermission() {
        if let settingsUrl = URL(string: "App-Prefs:root=GENERAL") {
            if UIApplication.shared.canOpenURL(settingsUrl) {
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(settingsUrl, options: [:], completionHandler: nil)
                } else {
                    UIApplication.shared.openURL(settingsUrl)
                }
            }
        }
    }
}
