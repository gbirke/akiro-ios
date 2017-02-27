//
//  ArrayExpenseResource.swift
//  Erster Test
//
//  Created by Gabriel Birke on 26.02.17.
//  Copyright © 2017 Gabriel Birke. All rights reserved.
//

import Foundation

class ArrayExpenseResource: ExpenseResource {
    
    var expenses: [Expense]
    
    init() {
        let foodCat = Category(name: "Auswärts essen", parent: "Allgemein")
        let bioCat =  Category(name: "Naturkost", parent: "Allgemein")
        
        /*
        let bioPayee1 = Payee(name: "LPG")
        let bioPayee2 = Payee(name: "Denn's")
        let foodPayee = Payee(name: "Sahara")
        */
        let now = Date()
        let yesterday = Date(timeIntervalSinceNow: -3600)
        
        expenses = [
            /*
            Expense(amount: -20.0, category: bioCat, date: now, payee: bioPayee1, memo:"" ),
            Expense(amount: -3.5, category: foodCat, date: now, payee: foodPayee, memo:"" ),
            Expense(amount: -2.5, category: foodCat, date: now, payee: nil, memo: "Süßigkeiten" ),
            Expense(amount: -4.91, category: bioCat, date: yesterday, payee: bioPayee2, memo:"" ),
            Expense(amount: -3.5, category: foodCat, date: yesterday, payee: foodPayee, memo:"" ),
            Expense(amount: 3.0, category: bioCat, date: yesterday, payee: nil, memo: "Rückgabe Rebecca" ),
 */
        ]
    }
    
    func getList() -> [Expense] {
        return expenses
    }
    
    func insert(expense: Expense) {
        expenses.insert(expense, at: 0)
    }
}
