//
//  QRCodeScanViewController.swift
//  restaurant-order
//
//  Created by Andrej Naumovski on 6/5/18.
//  Copyright © 2018 Andrej Naumovski. All rights reserved.
//

import UIKit
import RxSwift

class QRCodeScanViewController: UIViewController {
    private let qrCodeScanViewModel = QRCodeScanViewModel()
    private let restaurantViewModel = RestaurantViewModel.shared
    
    private let disposeBag = DisposeBag()

    private let tableDataView = UITextView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        qrCodeScanViewModel.tableData
            .asObservable()
            .observeOn(MainScheduler.instance)
            .subscribe() { [unowned self] tableData in
                if tableData.element?.tableNumber != -1 {
                    if let selectedRestaurant = self.restaurantViewModel.selectedRestaurant.value {
                        let containsTable = selectedRestaurant.tables!.contains { restaurantTableData in
                            return restaurantTableData.id == tableData.element?.id
                        }
                        if containsTable {
                            self.qrCodeScanViewModel.persistTableDataToRealm(tableData.element)
                            self.restaurantViewModel.persistRestaurantToRealm(selectedRestaurant)
                            self.performSegue(withIdentifier: "showMenuSegue", sender: nil)
                        } else {
                            self.showAlert(withTitle: "Invalid QR Code", withMessage: "The scanned table does not exist for the selected restaurant")
                        }
                    }
                }
            }
            .disposed(by: disposeBag)
        
        qrCodeScanViewModel.invalidQrCode
            .asObservable()
            .observeOn(MainScheduler.instance)
            .subscribe() { [unowned self] invalidQrCode in
                if invalidQrCode.element! {
                    self.showAlert(withTitle: "Invalid QR Code", withMessage: "The scanned QR Code is not registered with the application")
                }
            }
            .disposed(by: disposeBag)
        
        do {
            let videoLayer = try qrCodeScanViewModel.inintializeAndReturnVideoLayer()
            videoLayer.frame = view.layer.bounds
            view.layer.addSublayer(videoLayer)
            qrCodeScanViewModel.session.startRunning()
        } catch {
            print("Error")
        }
    }
    
    private func showAlert(withTitle title: String, withMessage message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "OK", style: .cancel) { _ in
            alertController.dismiss(animated: true, completion: nil)
        })
        
        present(alertController, animated: true, completion: nil)
    }
}
