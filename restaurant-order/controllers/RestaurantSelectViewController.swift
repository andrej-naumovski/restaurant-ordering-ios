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
import AVFoundation

class RestaurantSelectViewController: UIViewController {
    enum Permission: String {
        case camera = "Camera"
        case location = "Location"
    }
    
    @IBOutlet weak var scanQrCodeButton: UIButton!
    @IBOutlet weak var chooseLocationButton: UIButton!
    @IBOutlet weak var selectedRestaurantName: UILabel!
    
    private let locationViewModel = LocationViewModel()
    private let restaurantViewModel = RestaurantViewModel.shared
    
    private var activityIndicator: UIActivityIndicatorView?
    
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
        
        // Bind current restaurant name to field
        restaurantViewModel.selectedRestaurant
            .asObservable()
            .map { [unowned self] in
                self.activityIndicator?.removeFromSuperview()
                return $0?.name ?? ""
            }
            .bind(to: selectedRestaurantName.rx.text)
            .disposed(by: disposeBag)
        
        // Subscribe to changes of latLng
        self.activityIndicator = self.createAndStartActivityIndicator()
        locationViewModel.latLng
            .asObservable()
            .observeOn(MainScheduler.instance)
            .subscribe() { [unowned self] in
                if let latLng = $0.element! {
                    self.restaurantViewModel.fetchNearestRestaurants(userLocation: latLng)
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
                
                if isPermissionChecked && isPermissionDenied {
                    self.showPermissionDeniedAlert(for: .location)
                }
            }
            .disposed(by: disposeBag)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // Initiate fetching of location
        locationViewModel.updateUserLocation()
    }
    
    @IBAction func onRefreshLocationClick(_ sender: Any) {
        activityIndicator = createAndStartActivityIndicator()
        locationViewModel.updateUserLocation()
    }
    
    @IBAction func onScanQrCodeClick(_ sender: Any) {
        self.askForCameraPermission {
            self.performSegue(withIdentifier: "toQRCodeScanner", sender: nil)
        }
    }
    
    private func askForCameraPermission(_ handler: @escaping () -> Void) {
        AVCaptureDevice.requestAccess(for: .video) { [unowned self] response in
            if response {
                handler()
            } else {
                self.showPermissionDeniedAlert(for: .camera)
            }
            
        }
    }
    
    private func showPermissionDeniedAlert(for permission: Permission) {
        let alert = UIAlertController(title: "\(permission.rawValue) permission denied", message: "The application requires your location to work.", preferredStyle: UIAlertControllerStyle.alert)
        
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
    
    private func createAndStartActivityIndicator() -> UIActivityIndicatorView {
        if let existingActivityIndicator = self.activityIndicator {
            view.addSubview(existingActivityIndicator)
            existingActivityIndicator.startAnimating()
            return existingActivityIndicator
        }
        
        let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        
        view.addSubview(activityIndicator)
        
        activityIndicator.frame = view.bounds
        
        activityIndicator.backgroundColor = UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 0.7)
        
        activityIndicator.startAnimating()
        
        return activityIndicator
    }
}
