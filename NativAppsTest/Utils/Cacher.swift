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
        if var values = get(T.self, key: type) {
            values.append(value)
            UserDefaults.standard.set(
                try? PropertyListEncoder().encode(values), forKey: type.rawValue
            )
        } else {
            UserDefaults.standard.set(
                try? PropertyListEncoder().encode([value]), forKey: type.rawValue
            )
        }
    }

    static func get<T: Codable>(_ type: T.Type, key: CacheType) -> [T]? {
        var userData: [T]?
        if let data = UserDefaults.standard.value(forKey: key.rawValue) as? Data {
            userData = try? PropertyListDecoder().decode([T].self, from: data)
        }
        return userData
    }

    static func remove(type: CacheType) {
        UserDefaults.standard.removeObject(forKey: type.rawValue)
    }
}
