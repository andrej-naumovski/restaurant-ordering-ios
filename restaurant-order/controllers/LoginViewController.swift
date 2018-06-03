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
    @IBOutlet weak var errorLabel: UILabel!
    
    private let loginViewModel = LoginViewModel()

    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // If user is logged in redirect to restaurant selection
        if loginViewModel.isUserLoggedIn() {
            performSegue(withIdentifier: "toRestaurantSelect", sender: nil)
        }
        
        // Facebook login button custom style
        facebookLoginButton.layer.cornerRadius = facebookLoginButton.bounds.size.width * 0.5
        facebookLoginButton.clipsToBounds = true
        facebookLoginButton.titleLabel?.font = UIFont.fontAwesome(ofSize: 40)
        facebookLoginButton.setTitle(String.fontAwesomeIcon(name: .facebook), for: .normal)
        
        // Subscribe to changes on the facebookLogin model
        loginViewModel.facebookLogin
            .asObservable()
            .observeOn(MainScheduler.instance)
            .subscribe() { [unowned self] facebookLogin in
                if let isLoggedIn = facebookLogin.element?.isLoggedIn {
                    if isLoggedIn {
                        self.performSegue(withIdentifier: "restaurantSelection", sender: nil)
                    }
                }
                
                if let didLoginFail = facebookLogin.element?.didLoginFail {
                    self.errorLabel.isHidden = !didLoginFail
                }
            }
            .disposed(by: disposeBag)
    }
    
    @IBAction func onFacebookLoginButtonClick(_ sender: Any) {
        loginViewModel.loginWithFacebook()
    }
}

