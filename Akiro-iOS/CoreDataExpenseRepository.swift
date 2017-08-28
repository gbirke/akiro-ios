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
        
        return update(expense: expense, amount: amount, category: category, date: date, payee: payee, memo: memo)
    }
    
    func update(expense: Expense, amount:Float, category: Category, date: Date, payee: Payee?, memo: String?) -> Expense {
        let context = persistentContainer.viewContext
        
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
    
    func getList(startDate: Date) -> [Expense] {
        var expenses: [Expense] = []
        let request: NSFetchRequest<Expense> = Expense.fetchRequest()
        request.predicate = NSPredicate(format: "date >= %@", startDate as NSDate)
        request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: true)]
        do {
            try expenses = persistentContainer.viewContext.fetch(request)
        } catch {
            let nserror = error as NSError
            print("Database query error: \(nserror.localizedDescription)")
        }
        return expenses
    }
    
    func getFirstByPayee(payee: Payee) -> Expense? {
        var expenses: [Expense] = []
        let request: NSFetchRequest<Expense> = Expense.fetchRequest()
        
        request.fetchLimit = 1;
        request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        request.predicate = NSPredicate(format: "payee = %@", payee)
        do {
            try expenses = persistentContainer.viewContext.fetch(request)
        } catch {
            let nserror = error as NSError
            print("Database query error: \(nserror.localizedDescription)")
        }
        return expenses.first
    }
    
    func getCount() -> Int {
        let request: NSFetchRequest<Expense> = Expense.fetchRequest()
        do {
            return try persistentContainer.viewContext.count(for: request)
        } catch {
            print("Error getting entity count: \(error)")
        }
        return 0
    }
    
    func getCount(startDate: Date ) -> Int {
        let request: NSFetchRequest<Expense> = Expense.fetchRequest()
        request.predicate = NSPredicate(format: "date >= %@", startDate as NSDate)
        do {
            return try persistentContainer.viewContext.count(for: request)
        } catch {
            print("Error getting entity count: \(error)")
        }
        return 0
    }
    
}
