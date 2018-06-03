//
//  RestaurantSelectViewController.swift
//  restaurant-order
//
//  Created by Andrej Naumovski on 6/3/18.
//  Copyright © 2018 Andrej Naumovski. All rights reserved.
//

import UIKit

class RestaurantSelectViewController: UIViewController {
    @IBOutlet weak var scanQrCodeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // QR Code button additional style
        scanQrCodeButton.layer.cornerRadius = scanQrCodeButton.bounds.height * 0.5
    }
}
