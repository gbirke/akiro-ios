//
//  ExpenseResource.swift
//  Erster Test
//
//  Created by Gabriel Birke on 26.02.17.
//  Copyright © 2017 Gabriel Birke. All rights reserved.
//

import Foundation

protocol ExpenseResource {
    func getList() -> [Expense]
    func getList(startDate: Date) -> [Expense]
    func getCount() -> Int
    func getCount(startDate: Date) -> Int
    func insert(amount:Float, category: Category, date: Date, payee: Payee?, memo: String?) -> Expense
}

