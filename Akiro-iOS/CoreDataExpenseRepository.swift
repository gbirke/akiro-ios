//
//  CoreDataExpenseRepository.swift
//  Akiro-iOS
//
//  Created by Gabriel Birke on 27.02.17.
//  Copyright © 2017 Gabriel Birke. All rights reserved.
//

import Foundation
import CoreData

struct CoreDataExpenseResource: ExpenseResource {
    
    var persistentContainer: NSPersistentContainer
    
    init(withContainer: NSPersistentContainer) {
        persistentContainer = withContainer
    }
    
    func insert(amount:Float, category: Category, date: Date, payee: Payee?, memo: String?) -> Expense {
        let context = persistentContainer.viewContext
        let expense = NSEntityDescription.insertNewObject(forEntityName: "Expense", into: context) as! Expense
        
        expense.amount = amount
        expense.category = category
        expense.date = date as NSDate?
        expense.payee = payee
        expense.memo = memo
        
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                print("Database save error: \(nserror.localizedDescription)")
            }
        }
        return expense
    }
    
    func getList() -> [Expense] {
        var expenses: [Expense] = []
        let request: NSFetchRequest<Expense> = Expense.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: true)]
        do {
            try expenses = persistentContainer.viewContext.fetch(request)
        } catch {
            let nserror = error as NSError
            print("Database query error: \(nserror.localizedDescription)")
        }
        return expenses
    }
}
