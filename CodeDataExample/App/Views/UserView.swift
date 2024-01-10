//
//  UserView.swift
//  CodeDataExample
//
//  Created by Arken Sarsenov on 10.01.2024.
//

import UIKit
import SnapKit

class UserView: UIView {
    // MARK: - Properties
    private let identifier = "user-cell"
    private lazy var userNameTextField: UITextField = {
        let tf = UITextField()
        tf.borderStyle = .roundedRect
        tf.placeholder = "Enter your name here"
        return tf
    }()
    
    private lazy var pressButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .white
        button.setTitle("Press", for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(pressBtnTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var usersTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: identifier)
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    // MARK: - View Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MRK: - Actions
    @objc private func pressBtnTapped() {
        print("DEBUG: Press btn did tap")
    }
    
    // MARK: - SetupUI
    private func setupUI() {
        addSubview(userNameTextField)
        addSubview(pressButton)
        addSubview(usersTableView)
    }
    
    private func setupConstraints() {
        userNameTextField.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview().inset(10)
            make.height.equalTo(50)
        }
        pressButton.snp.makeConstraints { make in
            make.top.equalTo(userNameTextField.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(10)
            make.height.equalTo(50)
        }
        usersTableView.snp.makeConstraints { make in
            make.top.equalTo(pressButton.snp.bottom).offset(30)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}

// MARK: - UITableViewDelegate and UITableViewDataSource
extension UserView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        return cell
    }
}
