//
//  APIManager.swift
//  Movie Project
//
//  Created by Hamza Mehmood on 04/08/2023.
//

import Foundation
import Moya
import UIKit
import Alamofire

extension Encodable {

    /// Converting object to postable dictionary
    func toDictionary(_ encoder: JSONEncoder = JSONEncoder()) throws -> [String: Any] {
        let data = try encoder.encode(self)
        let object = try JSONSerialization.jsonObject(with: data)
        guard let json = object as? [String: Any] else {
            let context = DecodingError.Context(codingPath: [], debugDescription: "Deserialized object is not a dictionary")
            throw DecodingError.typeMismatch(type(of: object), context)
        }
        return json
    }
}

class APIManager {
    
    //MARK: - Auth APIs
    class func getMovieLists(page: String ,completion:@escaping ([Results]?, ErrorModel?)->Void) {
        Provider.services.request(.getMovieLists(page: page)) { result in
            switch result {
            case let .success(response):
                if response.statusCode == 200 {
                    do{
                        let results = try JSONDecoder().decode(Json4Swift_Base.self, from: response.data)
                        completion(results.results, nil)
                    }
                    catch let error {
                        completion(nil,customError(error: error))
                    }
                } else {
                    completion(nil,customError(error: response))
                }
            case let .failure(error):
                completion(nil,customError(error: error))
            }
        }
    }
    
    
    // MARK: - Error Handling
    
    class func customError(error:Error) -> ErrorModel {
        let result = ErrorModel(code: 500, messages: [error.localizedDescription])
        return result
    }
    
    class func customError(error:Response) -> ErrorModel {
        if error.response?.statusCode == 401 {
            UserDefaults.standard.isUserLoggedIn = false
            UserDefaults.standard.accessToken = ""
        }
        do {
            let json = try JSONSerialization.jsonObject(with: error.data, options: []) as? [String : Any]
            let results = try JSONDecoder().decode(ErrorBase.self, from: error.data)
            return results.error ?? ErrorModel(code: 422, messages: ["Data not Found."])
        }
        catch let error {
            let result = ErrorModel(code: 400, messages: [error.localizedDescription])
            return result
        }
    }
}

     //MARK: END
