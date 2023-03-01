//
//  HomeViewModel.swift
//  NativAppsTest
//
//  Created by Ernesto Jose Contreras Lopez on 1/3/23.
//

import Foundation

class HomeViewModel {
    
    private var reports: [Report] = [] {
        didSet {
            
        }
    }
    
    func dummyReports() -> [Report] {
        [
            Report(description: "Esto es una descripcion"),
            Report(description: "Esto es una descripcionEsto es una descripcionEsto es una descripcionEsto es una descripcionEsto es una descripcionEsto es una descripcionEsto es una descripcion"),
            Report(description: "Esto es una descripcionEsto es una descripcion"),
            Report(description: "Esto es una descripcionEsto es una descripcionEsto es una descripcionEsto es una descripcionEsto es una descripcion"),
            Report(description: "Esto es una descripcionEsto es una descripcionEsto es una descripcionEsto es una descripcionEsto es una descripcionEsto es una descripcionEsto es una descripcionEsto es una descripcionEsto es una descripcionEsto es una descripcionEsto es una descripcionEsto es una descripcionEsto es una descripcionEsto es una descripcion"),
            Report(description: "Esto es una descripcionEsto es una descripcionEsto es una descripcion"),
            Report(description: "Esto es una descripcionEsto es una descripcionEsto es una descripcionEsto es una descripcionEsto es una descripcionEsto es una descripcionEsto es una descripcionEsto es una descripcionEsto es una descripcionEsto es una descripcionEsto es una descripcionEsto es una descripcionEsto es una descripcionEsto es una descripcionEsto es una descripcionEsto es una descripcionEsto es una descripcionEsto es una descripcionEsto es una descripcionEsto es una descripcionEsto es una descripcionEsto es una descripcionEsto es una descripcionEsto es una descripcionEsto es una descripcionEsto es una descripcionEsto es una descripcionEsto es una descripcion"),
        ]
    }
    
    init() {
        self.reports = dummyReports()
    }
    
    func getReports() -> [Report] {
        self.reports
    }
}
