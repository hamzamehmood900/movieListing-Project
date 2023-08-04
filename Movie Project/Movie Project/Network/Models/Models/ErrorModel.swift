//
//  ErrorModel.swift
//  Movie Project
//
//  Created by Hamza Mehmood on 04/08/2023.
//

import Foundation
// MARK: - ErrorModel
struct ErrorModel: Codable {
    let code : Int?
    let messages : [String]?
}

struct SuccessBase : Codable {
    let response : SuccessModel?
}

struct SuccessModel: Codable {
    var messages: [String]?
    let code: Int?
}


struct ErrorBase: Codable {
    let error : ErrorModel?

    enum CodingKeys: String, CodingKey {

        case error = "error"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        error = try values.decodeIfPresent(ErrorModel.self, forKey: .error)
    }

}
