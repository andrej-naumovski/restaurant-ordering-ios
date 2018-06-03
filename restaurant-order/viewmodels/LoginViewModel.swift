//
//  LoginViewModel.swift
//  restaurant-order
//
//  Created by Andrej Naumovski on 6/2/18.
//  Copyright © 2018 Andrej Naumovski. All rights reserved.
//
import RxSwift
import FacebookLogin
import FacebookCore

class LoginViewModel {
    var facebookLogin = Variable<FacebookLogin>(FacebookLogin())
    
    func loginWithFacebook() {
        let loginManager = LoginManager()
        loginManager.logIn(readPermissions: [.publicProfile], viewController: nil) { [weak self] loginResult in
            switch loginResult {
            case .failed:
                self?.facebookLogin.value = FacebookLogin(isLoggedIn: false, didLoginFail: false)
            case .cancelled:
                self?.facebookLogin.value = FacebookLogin()
            case .success:
                self?.facebookLogin.value = FacebookLogin(isLoggedIn: true, didLoginFail: false)
            }
        }
    }
    
    func isUserLoggedIn() -> Bool {
        return AccessToken.current != nil
    }
}
