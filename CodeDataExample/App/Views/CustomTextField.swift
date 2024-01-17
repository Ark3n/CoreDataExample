//
//  CustomTextField.swift
//  CodeDataExample
//
//  Created by Arken Sarsenov on 17.01.2024.
//

import UIKit

final class CustomTextField: UITextField {
    // MARK: Properties
    private let padding = UIEdgeInsets(top: 0, left: 40, bottom: 0, right: 0)
    // MARK: - Init
    init(placeholder: String, systemImage: String) {
        super.init(frame: .zero)
        setupTextField(placeholder: placeholder, systemImage: systemImage)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }
    // MARK: - Private Methods
    private func setupTextField(placeholder: String, systemImage: String) {
        self.placeholder = placeholder
        self.borderStyle = .none
        
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.image = UIImage(systemName: systemImage)
        image.tintColor = .black
        image.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(image)
        
        let underline = UIView()
        underline.backgroundColor = .systemGray4
        underline.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(underline)
        
        NSLayoutConstraint.activate([
            image.centerYAnchor.constraint(equalTo: centerYAnchor),
            image.leadingAnchor.constraint(equalTo: leadingAnchor),
            underline.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            underline.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            underline.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            underline.heightAnchor.constraint(equalToConstant: 1),
            self.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
}


extension UITextField {
    func datePicker<T>(target: T,
                       doneAction: Selector,
                       cancelAction: Selector,
                       datePickerMode: UIDatePicker.Mode = .date) {
        let screenWidth = UIScreen.main.bounds.width
        
        func buttonItem(withSystemItemStyle style: UIBarButtonItem.SystemItem) -> UIBarButtonItem {
            let buttonTarget = style == .flexibleSpace ? nil : target
            let action: Selector? = {
                switch style {
                case .cancel:
                    return cancelAction
                case .done:
                    return doneAction
                default:
                    return nil
                }
            }()
            
            let barButtonItem = UIBarButtonItem(barButtonSystemItem: style,
                                                target: buttonTarget,
                                                action: action)
            
            return barButtonItem
        }
        
        let datePicker = UIDatePicker(frame: CGRect(x: 0,
                                                    y: 0,
                                                    width: screenWidth,
                                                    height: 216))
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        self.inputView = datePicker
        
        let toolBar = UIToolbar(frame: CGRect(x: 0,
                                              y: 0,
                                              width: screenWidth,
                                              height: 44))
        toolBar.setItems([buttonItem(withSystemItemStyle: .cancel),
                          buttonItem(withSystemItemStyle: .flexibleSpace),
                          buttonItem(withSystemItemStyle: .done)],
                         animated: true)
        self.inputAccessoryView = toolBar
    }
}
