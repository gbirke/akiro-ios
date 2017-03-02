//
//  Payee+CoreDataProperties.swift
//  Akiro-iOS
//
//  Created by Gabriel Birke on 02.03.17.
//  Copyright © 2017 Gabriel Birke. All rights reserved.
//

import Foundation
import CoreData


extension Payee {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Payee> {
        return NSFetchRequest<Payee>(entityName: "Payee");
    }

    @NSManaged public var name: String?
    @NSManaged public var expenses: NSSet?

}

// MARK: Generated accessors for expenses
extension Payee {

    @objc(addExpensesObject:)
    @NSManaged public func addToExpenses(_ value: Expense)

    @objc(removeExpensesObject:)
    @NSManaged public func removeFromExpenses(_ value: Expense)

    @objc(addExpenses:)
    @NSManaged public func addToExpenses(_ values: NSSet)

    @objc(removeExpenses:)
    @NSManaged public func removeFromExpenses(_ values: NSSet)

}
