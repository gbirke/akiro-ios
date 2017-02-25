//
//  ArrayCategoryResource.swift
//  Erster Test
//
//  Created by Gabriel Birke on 25.02.17.
//  Copyright © 2017 Gabriel Birke. All rights reserved.
//

import Foundation

class ArrayCategoryResource: CategoryResource {
    
    let categories = [
        Category(name: "Auswärts essen", parent: "Allgemein"),
        Category(name: "Supermarkt", parent: "Allgemein"),
        Category(name: "Naturkost", parent: "Allgemein"),
        Category(name: "Kontogebühren", parent: "Finanzen"),
        Category(name: "Hausratversicherung", parent: "Finanzen")
    ]
    
    func getList() -> [Category] {
        return categories
    }
}
