//
//  CoreDataManager.swift
//  CodeDataExample
//
//  Created by Arken Sarsenov on 10.01.2024.
//

import UIKit
import CoreData


final class CoreDataManager {
    public static let shared = CoreDataManager()
    private init() {}
    
    private var appDelegate: AppDelegate {
        UIApplication.shared.delegate as! AppDelegate
    }
    /// get context of persistent container
    private var context: NSManagedObjectContext {
        appDelegate.persistentContainer.viewContext
    }
    
    /// Create object and save to core data
    public func createPerson(_ name: String, dayOfBorn: String?, gender: String?, photo: Data? ) {
        guard let personEntityDescription = NSEntityDescription.entity(forEntityName: "Person", in: context)
        else { fatalError("Unaible create Entity Description") }
        
        let person = Person(entity: personEntityDescription, insertInto: context)
        person.name = name
        person.dayOfBorn = dayOfBorn
        person.gender = gender
        person.photo = photo
        
        appDelegate.saveContext()
    }
    
    public func featchPersons() -> [Person] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Person")
        var persons: [Person] = []
        do {
            persons = try context.fetch(fetchRequest) as! [Person]
        } catch let error {
            print(error.localizedDescription)
        }
        return persons
    }
    
    public func featchPerson(with name: String) -> Person? {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Person")
        do {
            let persons = try? context.fetch(fetchRequest) as? [Person]
            return persons?.first(where: { $0.name == name})
        }
    }
    
    public func updatePerson(with newPerson: Person) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Person")
        do {
            guard let persons = try? context.fetch(fetchRequest) as? [Person],
                  let person = persons.first(where: {$0.name == newPerson.name}) else { return }
            person.name = newPerson.name
            person.dayOfBorn = newPerson.dayOfBorn
            person.gender = newPerson.gender
            person.photo = newPerson.photo
        }
        appDelegate.saveContext()
    }
}

