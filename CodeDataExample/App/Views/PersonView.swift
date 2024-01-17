//
//  PersonView.swift
//  CodeDataExample
//
//  Created by Arken Sarsenov on 10.01.2024.
//

import UIKit
import SnapKit

final class PersonView: UIView {
    // MARK: - Properties
    private let identifier = "user-details-cell"
    private lazy var personPhoto: UIImageView = {
        let iv = UIImageView()
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFit
        iv.layer.cornerRadius = 200 / 2
        iv.backgroundColor = .systemGray3
        return iv
    }()
    
    private lazy var editPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Add photo", for: .normal)
        button.backgroundColor = .systemGray
        button.tintColor = .white
        button.layer.cornerRadius = 10
        button.isHidden = true
        return button
    }()
    
    private var usernameTextField = CustomTextField(placeholder: "user name", systemImage: "person")
    private var dayOfBornTextField = CustomTextField(placeholder: "Date", systemImage: "calendar")
    private var genderTextField = CustomTextField(placeholder: "Select gender", systemImage: "person.2.circle")
    
    private lazy var stackView: UIStackView = {
       let stack = UIStackView(arrangedSubviews: [usernameTextField, dayOfBornTextField, genderTextField])
        stack.axis = .vertical
        stack.distribution =  .equalSpacing
        return stack
    }()
    
    // MARK: - View Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
        dayOfBornTextField.datePicker(target: self,
                                          doneAction: #selector(doneAction),
                                          cancelAction: #selector(cancelAction),
                                          datePickerMode: .date)
        
        genderTextField.addBUtton(target: self, selector: #selector(switchGenderTapped))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    @objc
        func switchGenderTapped() {
            self.genderTextField.text = "Female"
    }
    @objc
        func cancelAction() {
            self.dayOfBornTextField.resignFirstResponder()
        }

        @objc
        func doneAction() {
            if let datePickerView = self.dayOfBornTextField.inputView as? UIDatePicker {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd-MM-yyyy"
                let dateString = dateFormatter.string(from: datePickerView.date)
                self.dayOfBornTextField.text = dateString
                self.dayOfBornTextField.resignFirstResponder()
            }
        }
    
    // MARK: - SetupUI
    private func setupUI() {
        addSubview(personPhoto)
        addSubview(editPhotoButton)
        addSubview(stackView)
    }
    
    private func setupConstraints() {
        personPhoto.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(200)
            make.centerX.equalToSuperview()
            make.width.equalTo(200)
            make.height.equalTo(200)
        }
        
        editPhotoButton.snp.makeConstraints { make in
            make.top.equalTo(personPhoto.snp.bottom).offset(10)
            make.centerX.equalTo(personPhoto)
            make.height.equalTo(40)
            make.width.equalTo(100)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(editPhotoButton.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().inset(10)
        }
    }
    
    public func configureUI(name: String, dayOfBorn: String = "not set", gender: String = "Male") {
        usernameTextField.text = name
        dayOfBornTextField.text = dayOfBorn
        genderTextField.text = gender
    }
}
