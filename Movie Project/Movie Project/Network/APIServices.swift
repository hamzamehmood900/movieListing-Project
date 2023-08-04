//
//  APIServices.swift
//  Movie Project
//
//  Created by Hamza Mehmood on 04/08/2023.
//

import Foundation
import Moya

enum APIServices {
    case getMovieLists(page: String)
}

extension APIServices: TargetType {
    var baseURL: URL {
        guard let url = URL(string: Constants.BaseURlDev) else { fatalError()}
        return url
    }
    
    var path: String {
        switch self {
        case .getMovieLists(_):
            return "popular"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getMovieLists:
            return .get

        }
    }
    
    var task: Task {
        switch self {
            //MARK: POST Apis.
        case .getMovieLists(let page):
            let params = ["page": page]
            return .requestParameters(parameters: params as [String : Any], encoding: URLEncoding.queryString)
            
            //MARK: MULTIPART Apis
        }
    }
    
    var headers: [String : String]? {
        switch self {
        default:
            return ["accept":"application/json","Authorization":"Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI2ODZjY2E0ZWUzNWFkYmM5ZDZlODI1NjczN2YzMjU3ZSIsInN1YiI6IjY0YzhkYzE5Yjk3NDQyMDBjYWJkYzExNyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.zTdAmEDHCqOpDNg9EkOP5tYQV186JHv1xvrAja9t-os"]
        }
    }
}
