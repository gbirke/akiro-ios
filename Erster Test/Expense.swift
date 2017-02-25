//
//  Expense.swift
//  Erster Test
//
//  Created by Gabriel Birke on 25.02.17.
//  Copyright © 2017 Gabriel Birke. All rights reserved.
//

import Foundation

struct Expense {
    var amount: Double
    var category: Category
    var date: Date
    var payee: Payee?
    var memo: String? = ""
}
