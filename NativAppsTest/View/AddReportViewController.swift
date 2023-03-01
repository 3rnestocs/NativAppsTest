//
//  AddReportViewController.swift
//  NativAppsTest
//
//  Created by Ernesto Jose Contreras Lopez on 1/3/23.
//

import UIKit

class AddReportViewController: UIViewController {

    // MARK: - Constants
    
    @IBOutlet private(set) weak var descriptionTextField: TextField!
    @IBOutlet private(set) weak var descriptionLabel: UILabel!
    @IBOutlet private(set) weak var titleLabel: UILabel!
    @IBOutlet private(set) weak var imageButton: UIButton!
    @IBOutlet private(set) weak var imageView: UIImageView!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet private(set) weak var imageContainerView: UIView!
    // MARK: - Properties
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
    }
    
    // MARK: - Setup
    private func setup() {
        self.setupUI()
    }
    
    private func setupUI() {
        setupTextField()
        setupButtons()
    }
    
    private func setupTextField() {
        self.descriptionTextField.attributedPlaceholder = NSAttributedString(string: "Descripción", attributes: [.foregroundColor: UIColor.lightGray])
        self.descriptionTextField.layer.cornerRadius = 24
        self.descriptionTextField.layer.borderColor = UIColor.black.cgColor
        self.descriptionTextField.layer.borderWidth = 1
    }
    
    private func setupButtons() {
        self.imageButton.layer.cornerRadius = 24
        self.imageButton.layer.borderColor = UIColor.black.cgColor
        self.imageButton.layer.borderWidth = 1
        
        self.saveButton.layer.cornerRadius = 24
        self.saveButton.layer.borderColor = UIColor.black.cgColor
        self.saveButton.layer.borderWidth = 1
    }
    
    // MARK: - Helpers
    
    // MARK: - Actions
    @IBAction func imageButtonTapped(_ sender: UIButton) {
    }

    @IBAction func saveButtonTapped(_ sender: UIButton) {
    }
}
