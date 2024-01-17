//
//  PersonController.swift
//  CodeDataExample
//
//  Created by Arken Sarsenov on 15.01.2024.
//

import UIKit

class PersonController: UIViewController {
    // MARK: - Properties
    private var personView = PersonView()
    var person: Person?
    
    // MARK: - View Lifecycle
    
    override func loadView() {
        view = personView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        if let person = person, let name = person.name {
            personView.configureUI(name: name)
        }
        
    }
    
    // MARK: - SetupUI
    private func setupUI() {
        view.backgroundColor = .systemBackground
    }
    private func setupConstraints() {}
}
