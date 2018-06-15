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
    
    private let disposeBag = DisposeBag()

    private let tableDataView = UITextView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        qrCodeScanViewModel.tableData
            .asObservable()
            .observeOn(MainScheduler.instance)
            .subscribe() { [unowned self] tableData in
                //TODO andrej-naumovski 15.06.2018: This is temporary, replace this with actual handling of received data
                if tableData.element?.tableNumber != -1 {
                    self.tableDataView.text = tableData.element?.restaurantName
                    self.tableDataView.frame = self.view.layer.bounds
                    for sublayer in self.view.layer.sublayers! {
                        sublayer.removeFromSuperlayer()
                    }
                    self.view.addSubview(self.tableDataView)
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
}
