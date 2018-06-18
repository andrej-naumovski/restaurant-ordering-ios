//
//  HttpUrlUtil.swift
//  restaurant-order
//
//  Created by Andrej Naumovski on 6/16/18.
//  Copyright © 2018 Andrej Naumovski. All rights reserved.
//

class HttpUrlUtil {
    class RequestUrlBuilder {
        private var baseUrl: String = ""
        private var queryParamString: String = ""
        private var pathVariableString = ""
        
        func base(_ baseUrl: String) -> RequestUrlBuilder {
            self.baseUrl = baseUrl
            return self
        }
        
        func withPathVariable(_ variable: String) -> RequestUrlBuilder {
            self.pathVariableString = "\(self.pathVariableString)\(variable)/"
            return self
        }
        
        func withQueryParams<T>(_ queryParams: Dictionary<String, T?>) -> RequestUrlBuilder {
            var isFirstParam = true
            for (paramName, paramValue) in queryParams {
                if isFirstParam {
                    self.queryParamString = "\(paramName)=\(paramValue!)"
                    isFirstParam = false
                } else {
                    self.queryParamString = "\(self.queryParamString)&\(paramName)=\(paramValue!)"
                }
            }
            return self
        }
        
        func build() -> String {
            return "\(self.baseUrl)/\(self.pathVariableString)?\(self.queryParamString)"
        }
    }
}
