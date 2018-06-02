//
//  LoginViewModel.swift
//  restaurant-order
//
//  Created by Andrej Naumovski on 6/2/18.
//  Copyright © 2018 Andrej Naumovski. All rights reserved.
//
import RxSwift

class LoginViewModel {
    var facebookLogin = Variable<FacebookLogin>(FacebookLogin())
    
    func loginWithFacebook() {
        // TODO andrej-naumovski 02.06.2018: Implement logic for logging in here
        facebookLogin.value.isLoggedIn = true
    }
}
