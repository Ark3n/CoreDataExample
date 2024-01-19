//
//  PersonController.swift
//  CodeDataExample
//
//  Created by Arken Sarsenov on 15.01.2024.
//

import UIKit

final class PersonController: UIViewController {
    // MARK: - Properties
    private var personView = PersonView()
    var person: Person?
    private var editMode: Bool = false
    
    private lazy var imagePicker: ImagePickerProtocol = {
            let imagePicker = ImagePicker(parentViewController: self)
            return imagePicker
        }()
    
    // MARK: - View Lifecycle
    
    override func loadView() {
        super.loadView()
        view = personView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        personView.delegate = self
        setupUI()
        setupConstraints()
        configureNavigationBarItem()
        configureUI()
    }
    
    private func configureUI() {
        if let person = person, let name = person.name {
            personView.configureUI(name: name)
        }
    }
    
    private func configureNavigationBarItem() {
        navigationItem.rightBarButtonItem = editButtonItem
        editButtonItem.action = #selector(editBarButtonTapped)
    }
    
    @objc private func editBarButtonTapped(sender: UIBarButtonItem) {
        if !editMode {
            sender.title = "Done"
            editMode = true
            personView.isEnabled(state: editMode)
        } else {
            sender.title = "Edit"
            editMode = false
            personView.isEnabled(state: editMode)
            personView.prepareForCoreDta()
        }
    }
    
    // MARK: - SetupUI
    private func setupUI() {
        view.backgroundColor = .systemBackground
    }
    private func setupConstraints() {}
}

extension PersonController: PersonViewDelegate {
    func editPhotoTapped() {
        imagePicker.startImagePicker(withSourceType: .photoLibrary) { [weak self] image in
            self!.personView.assignPhoto(image: image)
        }
    }
}
