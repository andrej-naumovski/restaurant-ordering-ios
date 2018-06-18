//
//  RestaurantService.swift
//  restaurant-order
//
//  Created by Andrej Naumovski on 6/16/18.
//  Copyright © 2018 Andrej Naumovski. All rights reserved.
//

import Foundation
import RxSwift
import RxAlamofire
import ObjectMapper

class RestaurantService {

    static let BASE_RESTAURANT_URL = "\(Bundle.main.infoDictionary!["API_ENDPOINT_URL"] as! String)/restaurants"
    
    static func getNearestRestaurants(for userLocation: LatLng) -> Observable<ApiResponse<RestaurantListDto>> {
        let queryParams = [
            "latitude": userLocation.latitude,
            "longitude": userLocation.longitude
        ]
        
        let requestUrl = HttpUrlUtil
            .RequestUrlBuilder()
            .base(RestaurantService.BASE_RESTAURANT_URL)
            .withPathVariable("nearest")
            .withQueryParams(queryParams)
            .build()
        
        return json(.get, requestUrl)
            .map { response -> ApiResponse<RestaurantListDto> in
                let mapper = Mapper<ApiResponse<RestaurantListDto>>()
                guard let decodedResponse = mapper.map(JSONObject: response) else {
                    throw ApiError.invalidResponse
                }
                return decodedResponse
            }
    }
}
