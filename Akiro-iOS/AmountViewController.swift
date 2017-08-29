//
//  AmountViewController.swift
//  Akiro-iOS
//
//  Created by Gabriel Birke on 29.08.17.
//  Copyright © 2017 Gabriel Birke. All rights reserved.
//

import UIKit

class AmountViewController: UIViewController {
    
    var delegate: ExpenseDelegate?
    var amountDelegate: AmountEntryDelegate?
    var editExpense: Expense?
    
    let formatter = NumberFormatter()
    
    var amount = 0 {
        didSet {
            amountDisplay.text = formatter.string(from: NSNumber(value: Float(amount) / 100))
            amountDelegate?.amountWasEntered(Float(amount) / 100)
        }
    };
    
    var expenseMode = true {
        didSet {
            if expenseMode {
                expenseModeButton.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
                expenseModeButton.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
                incomeModeButton.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                incomeModeButton.setTitleColor(#colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1), for: .normal)
                amountDisplay.textColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
            } else {
                expenseModeButton.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                expenseModeButton.setTitleColor(#colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1), for: .normal)
                incomeModeButton.backgroundColor = #colorLiteral(red: 0.5563425422, green: 0.9793455005, blue: 0, alpha: 1)
                incomeModeButton.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
                amountDisplay.textColor = #colorLiteral(red: 0.5563425422, green: 0.9793455005, blue: 0, alpha: 1)
            }
        }
    };

    @IBOutlet weak var amountDisplay: UILabel!
    @IBOutlet weak var expenseModeButton: UIButton!
    @IBOutlet weak var incomeModeButton: UIButton!
    
    @IBAction func numberTapped(_ sender: Any) {
        guard let button = sender as? UIButton else {
            return
        }
        amount = amount * 10 + button.tag
    }
    
    @IBAction func expenseModeTapped(_ sender: Any) {
        expenseMode = true;
    }
    @IBAction func incomeModeTapped(_ sender: Any) {
        expenseMode = false;
    }
    
    @IBAction func deleteTapped(_ sender: Any) {
        amount /= 10
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        formatter.locale = Locale(identifier: Locale.current.identifier)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "enterExpenseData" {
            let dst = segue.destination as! ExpenseEntryViewController
            dst.delegate = delegate
            dst.editExpense = editExpense
            dst.amountWasEntered(Float(amount) / 100)
        }
    }
    

}
