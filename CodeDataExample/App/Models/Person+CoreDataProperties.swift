//
//  Person+CoreDataProperties.swift
//  CodeDataExample
//
//  Created by Arken Sarsenov on 10.01.2024.
//
//

import Foundation
import CoreData

@objc(Person)
public class Person: NSManagedObject {

}
extension Person {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Person> {
        return NSFetchRequest<Person>(entityName: "Person")
    }
    
    @NSManaged public var name: String?
    @NSManaged public var dayOfBorn: String?
    @NSManaged public var gender: String?
    @NSManaged public var photo: Data?

}
extension Person : Identifiable {}
