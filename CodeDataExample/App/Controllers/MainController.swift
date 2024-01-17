//
//  ViewController.swift
//  CodeDataExample
//
//  Created by Arken Sarsenov on 10.01.2024.
//

import UIKit

final class MainController: UIViewController {

    
    // MARK: - Properties
    private let userView = PersonsView()
    
    private var persons: [Person] {
        CoreDataManager.shared.featchPersons()
    }
    
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

extension MainController: PersonViewDelegate {
    func navigateToPersonDetails(person: Person) {
        let vc = PersonController()
        vc.person = person
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func getPersons() -> [Person] {
        CoreDataManager.shared.featchPersons()
    }

    func addPerson(name: String) {
        CoreDataManager.shared.createPerson(name)
    }
}
