//
//  Cacher.swift
//  NativAppsTest
//
//  Created by Ernesto Jose Contreras Lopez on 1/3/23.
//

import Foundation

enum CacheType: String {
    case report = "reportData"
}

struct Cacher {
    static func save<T: Codable>(_ value: T, type: CacheType) {
        UserDefaults.standard.set(
            try? PropertyListEncoder().encode(value), forKey: type.rawValue
        )
    }

    static func get<T: Codable>(type: CacheType) -> T? {
        var userData: T?
        if let data = UserDefaults.standard.value(forKey: type.rawValue) as? Data {
            userData = try? PropertyListDecoder().decode(T.self, from: data)
            return userData
        } else {
            return userData
        }
    }

    static func remove(type: CacheType) {
        UserDefaults.standard.removeObject(forKey: type.rawValue)
    }
}
