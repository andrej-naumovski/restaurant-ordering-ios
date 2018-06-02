//
//  ViewController.swift
//  restaurant-order
//
//  Created by Andrej Naumovski on 6/2/18.
//  Copyright © 2018 Andrej Naumovski. All rights reserved.
//

import UIKit
import RxSwift
import FontAwesome_swift

class LoginViewController: UIViewController {
    @IBOutlet weak var facebookLoginButton: UIButton!
    
    private let loginViewModel = LoginViewModel()

    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Facebook login button custom style
        facebookLoginButton.layer.cornerRadius = facebookLoginButton.bounds.size.width * 0.5
        facebookLoginButton.clipsToBounds = true
        facebookLoginButton.titleLabel?.font = UIFont.fontAwesome(ofSize: 40)
        facebookLoginButton.setTitle(String.fontAwesomeIcon(name: .facebook), for: .normal)
        
        loginViewModel.facebookLogin
            .asObservable()
            .subscribe { (facebookLogin) in
                // TODO andrej-naumovski 02.06.2018: Implement logic for logging in/error handling here
                print(facebookLogin)
            }
        }
    
    @IBAction func onFacebookLoginButtonClick(_ sender: Any) {
        loginViewModel.loginWithFacebook()
    }
}

