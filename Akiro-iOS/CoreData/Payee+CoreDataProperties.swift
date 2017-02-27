//
//  Payee+CoreDataProperties.swift
//  Akiro-iOS
//
//  Created by Gabriel Birke on 26.02.17.
//  Copyright © 2017 Gabriel Birke. All rights reserved.
//

import Foundation
import CoreData


extension Payee {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Payee> {
        return NSFetchRequest<Payee>(entityName: "Payee");
    }

    @NSManaged public var name: String?
    @NSManaged public var expenses: Expense?

}
