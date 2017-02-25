//
//  CategoryViewController.swift
//  Erster Test
//
//  Created by Gabriel Birke on 25.02.17.
//  Copyright © 2017 Gabriel Birke. All rights reserved.
//

import Foundation

class CategoryViewController: ItemListViewController {
    
    var categories: [Category]? {
        didSet {
            self.tableView.reloadData()
        }
    }
    
}
