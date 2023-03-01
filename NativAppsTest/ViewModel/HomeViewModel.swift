//
//  HomeViewModel.swift
//  NativAppsTest
//
//  Created by Ernesto Jose Contreras Lopez on 1/3/23.
//

import Foundation

class HomeViewModel {
    
    var reportCompletion: (() -> Void)?
    
    private var reports: [Report]? {
        didSet {
            self.reportCompletion?()
        }
    }
    
    init() {
        self.reports = Cacher.get(Report.self, key: .report)
    }
    
    func updateReports() {
        if let updatedReports = Cacher.get(Report.self, key: .report) {
            self.reports = updatedReports
        }
    }
    
    func getReports() -> [Report] {
        self.reports ?? []
    }
}
