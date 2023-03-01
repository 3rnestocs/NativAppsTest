//
//  AddReportViewController.swift
//  NativAppsTest
//
//  Created by Ernesto Jose Contreras Lopez on 1/3/23.
//

import UIKit
import AVFoundation

protocol AddReportViewControllerDelegate: AnyObject {
    func didSave()
}

class AddReportViewController: UIViewController {

    // MARK: - Outlet
    @IBOutlet private(set) weak var descriptionTextField: TextField!
    @IBOutlet private(set) weak var descriptionLabel: UILabel!
    @IBOutlet private(set) weak var titleLabel: UILabel!
    @IBOutlet private(set) weak var imageButton: UIButton!
    @IBOutlet private(set) weak var imageView: UIImageView!
    @IBOutlet private(set) weak var saveButton: UIButton!
    @IBOutlet private(set) weak var imageContainerView: UIView!
    @IBOutlet private(set) weak var descriptionAlertLabel: UILabel!
    @IBOutlet private(set) weak var imageAlertLabel: UILabel!
    
    private var currentImage: UIImage? {
        didSet {
            if let image = currentImage {
                self.imageView.image = image
            }
        }
    }
    private let cameraAuthorizationStatus = AVCaptureDevice.authorizationStatus(for: .video)
    private var viewModel = AddReportViewModel()
    weak var delegate: AddReportViewControllerDelegate?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
    }
    
    // MARK: - Setup
    private func setup() {
        setupObserver()
        self.setupUI()
    }
    
    private func setupObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleSave), name: .didSaveReport, object: nil)
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
    private func checkCameraStatus() {
        switch cameraAuthorizationStatus {
        case .authorized:
            presentCamera()
        case .restricted, .denied:
            alertCameraAccessNeeded()
        default:
            requestCameraPermission()
        }
    }

    private func presentCamera() {
        let vc = UIImagePickerController()
        vc.sourceType = .camera
        vc.allowsEditing = true
        vc.delegate = self
        present(vc, animated: true)
    }
    
    private func requestCameraPermission() {
        AVCaptureDevice.requestAccess(for: .video, completionHandler: {accessGranted in
            guard accessGranted == true else {
                self.handleSave()
                return
            }
            self.presentCamera()
        })
    }
    
    private func alertCameraAccessNeeded() {
        let settingsAppURL = URL(string: UIApplication.openSettingsURLString)
        
        let alert = UIAlertController(
            title: "Acceso requerido",
            message: "Se requiere de acceso a la camara de tu dispositivo para hacer uso de esta aplicación.",
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "Cancelar", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "Dar permisos de cámara", style: .cancel, handler: { (alert) -> Void in
            if let settingsURL = settingsAppURL {
                UIApplication.shared.open(settingsURL, options: [:], completionHandler: nil)
            }
        }))
        
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Actions
    @objc private func handleSave() {
        self.delegate?.didSave()
        DispatchQueue.main.async {
            self.dismiss(animated: true)
        }
    }
    
    @objc private func viewTapped() {
        self.view.endEditing(true)
    }
    
    @IBAction private func imageButtonTapped(_ sender: UIButton) {
        checkCameraStatus()
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
