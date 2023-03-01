//
//  HomeTableViewCell.swift
//  NativAppsTest
//
//  Created by Ernesto Jose Contreras Lopez on 1/3/23.
//

import UIKit

class HomeTableViewCell: UITableViewCell {

    // MARK: - Constant
    static let cellIdentifier = String(describing: HomeTableViewCell.self)
    
    // MARK: - Outlets
    @IBOutlet private(set) weak var textView: UITextView!
    @IBOutlet private(set) weak var reportImageView: UIImageView!
    
    // MARK: - Properties
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: - Setup
    func setupCell(_ report: Report) {
        self.textView.text = report.description
        if let image = report.image {
            self.reportImageView.image = UIImage(named: image)
        }
    }
}
