//
//  PayeeResource.swift
//  Erster Test
//
//  Created by Gabriel Birke on 25.02.17.
//  Copyright © 2017 Gabriel Birke. All rights reserved.
//

import Foundation

protocol PayeeResource {
    func getList() -> [Payee]
    func insert(withName: String) -> Payee
}
