//
//  ExpenseDelegate.swift
//  Erster Test
//
//  Created by Gabriel Birke on 26.02.17.
//  Copyright © 2017 Gabriel Birke. All rights reserved.
//

import Foundation

protocol ExpenseDelegate {
    func addExpense( amount:Float, category: Category, date: Date, payee: Payee?, memo: String? )
}
