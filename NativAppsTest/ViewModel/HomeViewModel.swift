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
    
    func getReports() -> [Report] {
        self.reports
    }
}
