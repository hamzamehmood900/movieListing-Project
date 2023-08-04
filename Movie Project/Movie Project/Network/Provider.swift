//
//  Provider.swift
//  Movie Project
//
//  Created by Hamza Mehmood on 04/08/2023.
//

import Foundation
import Moya

struct Provider {
    static let services = MoyaProvider<APIServices>(plugins: [Plugin.networkPlugin, NetworkLoggerPlugin()])
    static let backgroundServices = MoyaProvider<APIServices>(plugins: [NetworkLoggerPlugin()])
}
