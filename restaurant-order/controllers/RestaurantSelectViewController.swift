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
    @IBOutlet weak var chooseLocationButton: UIButton!
    
    private let locationViewModel = LocationViewModel()
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // QR Code button additional style
        scanQrCodeButton.layer.cornerRadius = scanQrCodeButton.bounds.height * 0.5
        
        scanQrCodeButton.setTitleColor(UIColor.gray, for: .disabled)
        chooseLocationButton.setTitleColor(UIColor.gray, for: .disabled)
        
        // Bind buttons' isEnabled to the negated value of locationViewModel.isPermissionDenied
        let isPermissionGranted = locationViewModel.isPermissionDenied.asObservable().map { !$0 }
        
        isPermissionGranted
            .bind(to: scanQrCodeButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        isPermissionGranted
            .bind(to: chooseLocationButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
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
        Observable
            .combineLatest(locationViewModel.isPermissionChecked.asObservable(), locationViewModel.isPermissionDenied.asObservable())
            .observeOn(MainScheduler.instance)
            .subscribe() { [unowned self] in
                let isPermissionChecked = $0.element?.0 ?? false
                let isPermissionDenied = $0.element?.1 ?? false
                                
                print(isPermissionChecked, isPermissionDenied)
                
                if isPermissionChecked && isPermissionDenied {
                    self.showPermissionDeniedAlert()
                }
            }
            .disposed(by: disposeBag)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // Initiate fetching of location
        locationViewModel.updateUserLocation()
    }
    
    @IBAction func onRefreshLocationClick(_ sender: Any) {
        locationViewModel.updateUserLocation()
    }
    
    private func showPermissionDeniedAlert() {
        let alert = UIAlertController(title: "Location permission denied", message: "The application requires your location to work.", preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "Go to Settings", style: UIAlertActionStyle.default, handler: { [unowned self] _ in
            self.openSettingsOnDeniedPermission()
        }))
        
        alert.addAction(UIAlertAction(title: "Close", style: UIAlertActionStyle.cancel, handler: { _ in
            alert.dismiss(animated: true, completion: nil)
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
