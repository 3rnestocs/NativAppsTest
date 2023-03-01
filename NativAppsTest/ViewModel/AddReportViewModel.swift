//
//  AddReportViewModel.swift
//  NativAppsTest
//
//  Created by Ernesto Jose Contreras Lopez on 1/3/23.
//

import Foundation

class AddReportViewModel {
    var report: Report? {
        didSet {
            updateReportLocally()
        }
    }
    
    private func updateReportLocally() {
        if let report = self.report {
            print("T3ST saving", report)
            Cacher.save(report, type: .report)
        }
    }
    
    func saveReport(_ image: Data?, description: String?) {
        if let data = image, let text = description {
            let documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let formatter = DateFormatter()
            formatter.dateFormat = "MMM-d-yyyy"
            let url = documents.appendingPathComponent("\(formatter.string(from: Date())).png")
            do {
                try data.write(to: url)
                self.report = Report(image: url.absoluteString, description: text)
            } catch {
                print("Unable to Write Data to Disk (\(error))")
            }
        }
    }
}
