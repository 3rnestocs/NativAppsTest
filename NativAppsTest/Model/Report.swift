//
//  Report.swift
//  NativAppsTest
//
//  Created by Ernesto Jose Contreras Lopez on 1/3/23.
//

import Foundation

struct Report: Codable {
    var image: Data?
    var description: String
    var createdAt: Date = Date()
}
