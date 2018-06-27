//
//  OrderService.swift
//  restaurant-order
//
//  Created by Andrej Naumovski on 6/27/18.
//  Copyright © 2018 Andrej Naumovski. All rights reserved.
//

import Foundation
import RxSwift
import Alamofire
import RxAlamofire
import ObjectMapper

class OrderService {
    static let BASE_ORDER_URL = "\(Bundle.main.infoDictionary!["API_ENDPOINT_URL"] as! String)/orders"
    
    static func createOrder(with order: Order?) -> Observable<ApiResponse<OrderDto>> {
        let url = HttpUrlUtil.RequestUrlBuilder()
            .base(BASE_ORDER_URL)
            .build()
        
        let itemsBody = order?.items?.map { item in
            return [
                "id": item.id ?? "",
                "category": item.category ?? ""
            ]
        }
        
        let body = [
            "restaurantId": order?.restaurantId ?? "",
            "tableId": order?.tableId ?? "",
            "items": itemsBody
            ] as [String : Any]
        
        
        return json(.post, url, parameters: body, encoding: URLEncoding.httpBody)
            .map { response -> ApiResponse<OrderDto> in
                print(response)
                let mapper = Mapper<ApiResponse<OrderDto>>()
                guard let decodedResponse = mapper.map(JSONObject: response) else {
                    throw ApiError.invalidResponse
                }
                
                return decodedResponse
            }
    }
}
