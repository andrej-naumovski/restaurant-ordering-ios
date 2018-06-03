//
//  FacebookLogin.swift
//  restaurant-order
//
//  Created by Andrej Naumovski on 6/2/18.
//  Copyright © 2018 Andrej Naumovski. All rights reserved.
//

struct FacebookLogin {
    var isLoggedIn: Bool
    var didLoginFail: Bool
    
    init(isLoggedIn: Bool = false, didLoginFail: Bool = false) {
        self.isLoggedIn = isLoggedIn
        self.didLoginFail = didLoginFail
    }
}
