//
//  UserResponse.swift
//  Movie Project
//
//  Created by Hamza Mehmood on 04/08/2023.
//

import Foundation
struct Response_Model : Codable {
    let code : Int?
    let messages : [String]?
    let data : Data_Model?

    enum CodingKeys: String, CodingKey {

        case code = "code"
        case messages = "messages"
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        code = try values.decodeIfPresent(Int.self, forKey: .code)
        messages = try values.decodeIfPresent([String].self, forKey: .messages)
        data = try values.decodeIfPresent(Data_Model.self, forKey: .data)
    }
}



struct Data_Model : Codable {
    let page : Int?
    let results : [Results]?
    let total_pages : Int?
    let total_results : Int?

    enum CodingKeys: String, CodingKey {

        case page = "page"
        case results = "results"
        case total_pages = "total_pages"
        case total_results = "total_results"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        page = try values.decodeIfPresent(Int.self, forKey: .page)
        results = try values.decodeIfPresent([Results].self, forKey: .results)
        total_pages = try values.decodeIfPresent(Int.self, forKey: .total_pages)
        total_results = try values.decodeIfPresent(Int.self, forKey: .total_results)
    }

}


struct Json4Swift_Base : Codable {
    let page : Int?
    let results : [Results]?
    let total_pages : Int?
    let total_results : Int?

    enum CodingKeys: String, CodingKey {

        case page = "page"
        case results = "results"
        case total_pages = "total_pages"
        case total_results = "total_results"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        page = try values.decodeIfPresent(Int.self, forKey: .page)
        results = try values.decodeIfPresent([Results].self, forKey: .results)
        total_pages = try values.decodeIfPresent(Int.self, forKey: .total_pages)
        total_results = try values.decodeIfPresent(Int.self, forKey: .total_results)
    }

}
