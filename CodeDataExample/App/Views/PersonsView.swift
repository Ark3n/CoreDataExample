//
//  UserView.swift
//  CodeDataExample
//
//  Created by Arken Sarsenov on 10.01.2024.
//

import UIKit
import SnapKit

protocol PersonViewDelegate: AnyObject {
    func addPerson(name: String)
}
final class PersonsView: UIView, UITextFieldDelegate {
    // MARK: - Properties
    private let identifier = "user-cell"
    
    weak var delegate: PersonViewDelegate?
    private var persons: [Person] {
        CoreDataManager.shared.featchPersons()
    }
    
    private lazy var personTextField: UITextField = {
        let tf = UITextField()
        tf.borderStyle = .roundedRect
        tf.placeholder = "Enter a person name here"
        tf.delegate = self
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
    
    private lazy var personsTableView: UITableView = {
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
        guard let text = personTextField.text else { return }
        delegate?.addPerson(name: text)
        personsTableView.reloadData()
    }
    
    // MARK: - SetupUI
    private func setupUI() {
        addSubview(personTextField)
        addSubview(pressButton)
        addSubview(personsTableView)
    }
    
    private func setupConstraints() {
        personTextField.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }
        pressButton.snp.makeConstraints { make in
            make.top.equalTo(personTextField.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }
        personsTableView.snp.makeConstraints { make in
            make.top.equalTo(pressButton.snp.bottom).offset(30)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}


// MARK: - UITableViewDelegate and UITableViewDataSource
extension PersonsView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        persons.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        cell.textLabel?.text = persons[indexPath.row].name
        return cell
    }    
    
    // MARK: - UITextFieldDelegate

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        personTextField.resignFirstResponder()
        return true
    }
}
