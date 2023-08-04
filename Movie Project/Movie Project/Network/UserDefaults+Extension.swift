//
//  UserDefaults+Extension.swift
//  Movie Project
//
//  Created by Hamza Mehmood on 04/08/2023.
//

import Foundation
import UIKit
import AVFoundation
import SwiftUI

extension UserDefaults {
    private struct Keys {
        // MARK: - Constants
        static let isUserLoggedIn = "isUserLoggedIn"
        static let loggedInUser = "loggedInUser"
        static let accessToken = "accessToken"
    }
    
    
    
    var isUserLoggedIn: Bool {
        get {
            return UserDefaults.standard.bool(forKey: UserDefaults.Keys.isUserLoggedIn)
        }
        set {
            let defaults = UserDefaults.standard
            defaults.setValue(newValue, forKey: UserDefaults.Keys.isUserLoggedIn)
            defaults.synchronize()
        }
    }
    
    var loggedInUser: Results? {
        get {
            return  UserDefaults.standard.pDecode(for: Results.self, using: UserDefaults.Keys.loggedInUser) ?? nil
        }
        set {
            UserDefaults.standard.pEncode(for: newValue, using: UserDefaults.Keys.loggedInUser)
            UserDefaults.standard.synchronize()
        }
    }
    
    
    var accessToken:String? {
        get{
            return  UserDefaults.standard.value(forKey: UserDefaults.Keys.accessToken) as? String
        }
        set{
            let defaults = UserDefaults.standard
            defaults.setValue(newValue, forKey: UserDefaults.Keys.accessToken)
            defaults.synchronize()
        }
    }

    func pDecode<T : Codable>(for type: T.Type, using key : String) -> T? {
        guard let data = UserDefaults.standard.object(forKey: key) as? Data else { return nil }
        return try? PropertyListDecoder().decode(type, from: data)
    }
    
    func pEncode<T : Codable>(for type: T?, using key : String) {
        let encodedData = try? PropertyListEncoder().encode(type)
        UserDefaults.standard.set(encodedData, forKey: key)
        UserDefaults.standard.synchronize()
    }
}
