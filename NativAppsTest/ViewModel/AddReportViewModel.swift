//
//  AddReportViewModel.swift
//  NativAppsTest
//
//  Created by Ernesto Jose Contreras Lopez on 1/3/23.
//

import Foundation

class AddReportViewModel {
    private var report: Report?
    
    private func updateReportLocally() {
        if let report = self.report {
            Cacher.save(report, type: .report)
            NotificationCenter.default.post(name: .didSaveReport, object: nil)
        }
    }
    
    func saveReport(_ image: Data?, description: String?) {
        if let data = image, let text = description {
            let documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let url = documents.appendingPathComponent("\(UUID().uuidString).png" )
            do {
                try data.write(to: url)
                let imageData = try Data(contentsOf: url)
                self.report = Report(image: imageData, description: text)
                self.updateReportLocally()
            } catch {
                print("Unable to Write Data to Disk (\(error.localizedDescription))")
            }
        }
    }
}
