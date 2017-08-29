//
//  ExpenseViewCell.swift
//  Erster Test
//
//  Created by Gabriel Birke on 25.02.17.
//  Copyright © 2017 Gabriel Birke. All rights reserved.
//

import UIKit

class ExpenseViewCell: UITableViewCell {
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var format: NumberFormatter
    
    required init?(coder aDecoder: NSCoder) {
        format = NumberFormatter()
        format.numberStyle = .currency
        format.maximumFractionDigits = 2
        format.minimumFractionDigits = 2
        format.locale = Locale(identifier: Locale.current.identifier)
        
        super.init(coder: aDecoder)
    }
    
    var expense: Expense? {
        didSet {
            guard let setExpense = expense else {
                return
            }

            
            
            priceLabel?.text = format.string(from: setExpense.amount as NSNumber)
            if ( setExpense.amount < 0 ) {
                priceLabel?.textColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
            } else {
                priceLabel?.textColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
            }
            descriptionLabel?.text = setExpense.payee?.name ?? setExpense.category?.name ?? "Unclassified"
        }
    }
    
}
