//
//  ArrayCategoryResource.swift
//  Erster Test
//
//  Created by Gabriel Birke on 25.02.17.
//  Copyright © 2017 Gabriel Birke. All rights reserved.
//

import Foundation

class ArrayCategoryResource: CategoryResource {
    
    let categories:[Category] = []
    
    func getList() -> [Category] {
        return categories
    }
}
