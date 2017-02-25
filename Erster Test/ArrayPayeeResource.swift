//
//  ArrayPayeeResource.swift
//  Erster Test
//
//  Created by Gabriel Birke on 25.02.17.
//  Copyright © 2017 Gabriel Birke. All rights reserved.
//

import Foundation

/**
 * An im-memory list of payees
 */
class ArrayPayeeResource: PayeeResource {
    
    private var payees: [Payee]
    
    init() {
        payees = [
            Payee(name: "Foo"),
            Payee(name: "Bar")
        ]
    }
    
    func getList() -> [Payee] {
        return payees
    }
    
}
