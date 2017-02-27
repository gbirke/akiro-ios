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
        
        
        expenses = []
    }
    
    func getList() -> [Expense] {
        return expenses
    }
    
    func insert(expense: Expense) {
        expenses.insert(expense, at: 0)
    }
}
