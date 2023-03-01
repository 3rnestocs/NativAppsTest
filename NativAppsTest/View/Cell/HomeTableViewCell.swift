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
    @IBOutlet private(set) weak var reportLabel: UILabel!
    @IBOutlet private(set) weak var imageContainerView: UIView!
    @IBOutlet private(set) weak var reportImageView: UIImageView!
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        reportImageView.layer.cornerRadius = 30
    }
    
    // MARK: - Setup
    func setupCell(_ report: Report) {
        self.reportLabel.text = report.description.firstCapitalized
        if let data = report.image {
            self.reportImageView.image = UIImage(data: data)
        } else {
            self.imageContainerView.isHidden = true
        }
    }
}
