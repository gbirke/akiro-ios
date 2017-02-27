//
//  Expense+CoreDataProperties.swift
//  Akiro-iOS
//
//  Created by Gabriel Birke on 27.02.17.
//  Copyright © 2017 Gabriel Birke. All rights reserved.
//

import Foundation
import CoreData


extension Expense {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Expense> {
        return NSFetchRequest<Expense>(entityName: "Expense");
    }

    @NSManaged public var amount: Float
    @NSManaged public var date: NSDate?
    @NSManaged public var memo: String?
    @NSManaged public var category: Category?
    @NSManaged public var payee: Payee?

}
