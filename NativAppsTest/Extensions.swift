//
//  Extensions.swift
//  NativAppsTest
//
//  Created by Ernesto Jose Contreras Lopez on 1/3/23.
//

import UIKit

extension UITableView {
    func emptyMessage(message:String) {
        let rect = CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: self.frame.width / 2, height: self.frame.height))
        let lblMsg = UILabel(frame: rect)
        let messageLabel = lblMsg
        messageLabel.text = message
        messageLabel.textColor = UIColor.lightGray
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        self.backgroundView = messageLabel
    }
}
