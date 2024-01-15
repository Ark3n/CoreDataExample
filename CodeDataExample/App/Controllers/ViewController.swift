//
//  ViewController.swift
//  CodeDataExample
//
//  Created by Arken Sarsenov on 10.01.2024.
//

import UIKit

final class ViewController: UIViewController {

    
    // MARK: - Properties
    private let userView = PersonsView()
    
    override func loadView() {
        view = userView
    }
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        userView.delegate = self
        setupUI()
    }
    
    // MARK: - SetupUI
    private func setupUI() {
        title = "Users"
        view.backgroundColor = .systemBackground
    }
}

extension ViewController: PersonViewDelegate {
    func addPerson(name: String) {
        CoreDataManager.shared.createPerson(name)
    }
}
