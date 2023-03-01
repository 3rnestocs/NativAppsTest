//
//  AddReportViewController.swift
//  NativAppsTest
//
//  Created by Ernesto Jose Contreras Lopez on 1/3/23.
//

import UIKit

class AddReportViewController: UIViewController {

    // MARK: - Outlet
    @IBOutlet private(set) weak var descriptionTextField: TextField!
    @IBOutlet private(set) weak var descriptionLabel: UILabel!
    @IBOutlet private(set) weak var titleLabel: UILabel!
    @IBOutlet private(set) weak var imageButton: UIButton!
    @IBOutlet private(set) weak var imageView: UIImageView!
    @IBOutlet private(set) weak var saveButton: UIButton!
    @IBOutlet private(set) weak var imageContainerView: UIView!
    @IBOutlet weak var descriptionAlertLabel: UILabel!
    @IBOutlet weak var imageAlertLabel: UILabel!
    
    private var currentImage: UIImage? {
        didSet {
            if let image = currentImage {
                self.imageView.image = image
            }
        }
    }
    private var viewModel = AddReportViewModel()
    
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
        view.layer.cornerRadius = 40
        setupTextField()
        setupButtons()
        setupGesture()
        setupImage()
    }
    
    private func setupGesture() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        self.view.addGestureRecognizer(gesture)
    }
    
    private func setupTextField() {
        self.descriptionTextField.delegate = self
        self.descriptionTextField.attributedPlaceholder = NSAttributedString(string: "Descripción", attributes: [.foregroundColor: UIColor.lightGray])
        self.descriptionTextField.layer.cornerRadius = 20
        self.descriptionTextField.layer.borderColor = UIColor.black.cgColor
        self.descriptionTextField.layer.borderWidth = 1
    }
    
    private func setupButtons() {
        self.imageButton.layer.cornerRadius = 20
        self.imageButton.layer.borderColor = UIColor.black.cgColor
        self.imageButton.layer.borderWidth = 1
        
        self.saveButton.layer.cornerRadius = 20
        self.saveButton.layer.borderColor = UIColor.black.cgColor
        self.saveButton.layer.borderWidth = 1
    }
    
    private func setupImage() {
        self.imageView.layer.cornerRadius = 60
    }
    
    // MARK: - Helpers
    
    // MARK: - Actions
    @objc private func viewTapped() {
        self.view.endEditing(true)
    }
    
    @IBAction private func imageButtonTapped(_ sender: UIButton) {
        let vc = UIImagePickerController()
        vc.sourceType = .camera
        vc.allowsEditing = true
        vc.delegate = self
        present(vc, animated: true)
    }

    @IBAction private func saveButtonTapped(_ sender: UIButton) {
        var hasValidText: Bool = false
        if let textField = descriptionTextField.text, !textField.isEmpty {
            descriptionAlertLabel.isHidden = true
            hasValidText = true
        } else {
            descriptionAlertLabel.isHidden = false
            hasValidText = false
        }
        
        var hasValidImage: Bool = false
        if currentImage != nil {
            imageAlertLabel.isHidden = true
            hasValidImage = true
        } else {
            imageAlertLabel.isHidden = false
            hasValidImage = false
        }
         
        if hasValidText, hasValidImage {
            viewModel.saveReport(
                currentImage?.pngData(), description: descriptionTextField.text
            )
        }
    }
}

extension AddReportViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        descriptionAlertLabel.isHidden = true
        return true
    }
}

extension AddReportViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)

        guard let image = info[.editedImage] as? UIImage else {
            fatalError("There was no image found.")
        }
        self.currentImage = image
    }
}
