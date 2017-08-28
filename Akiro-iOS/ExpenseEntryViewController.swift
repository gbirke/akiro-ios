//
//  ExpenseEntryViewController.swift
//  Erster Test
//
//  Created by Gabriel Birke on 26.02.17.
//  Copyright © 2017 Gabriel Birke. All rights reserved.
//

import UIKit

class ExpenseEntryViewController: UITableViewController, PayeeSelectionDelegate, CategorySelectionDelegate, DateSelectionDelegate {

    private var amount: Float = 0.0
    private var category: Category? {
        didSet {
            if category == nil {
                selectedCategoryLabel.textColor =  #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
                selectedCategoryLabel.text = "Select category"
            } else {
                selectedCategoryLabel.textColor =  #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                selectedCategoryLabel.text = category!.name
            }
        }
    }
    private var payee: Payee? {
        didSet {
            if payee == nil {
                selectedPayeeLabel.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
                selectedPayeeLabel.text = "Select payee"
            } else {
                selectedPayeeLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                selectedPayeeLabel.text = payee!.name
            }
            
        }
    }
    private var memo: String?
    private var dateEntered: Date? {
        didSet {
            if dateEntered == nil {
                return
            }
            let formatter = DateFormatter()
            formatter.dateStyle = .short
            selectedDateLabel?.text = formatter.string(from: dateEntered!)
        }
    }
    
    var editExpense: Expense?
    
    var delegate: ExpenseDelegate?
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    @IBAction func amountEntered(_ sender: UITextField) {
        if let textEntered = sender.text, let convertedAmount = Float(textEntered.replacingOccurrences(of: ",", with: ".")) { // Crude float conversion for german numbers until we have fancy amount input
            amount = convertedAmount
            editExpense?.amount = convertedAmount
        }
    }
    
    @IBAction func saveTouched(_ sender: Any) {
        if amount == 0.0 {
            flashInvalidField(view: amountField.superview)
            return
        }
        
        if category == nil  {
            flashInvalidField(view: selectedCategoryLabel.superview )
            return
        }
        
        if dateEntered == nil {
            flashInvalidField(view: selectedPayeeLabel.superview)
            return
        }
        
        
        if editExpense == nil {
            delegate?.addExpense(amount: -amount, category: category!, date: dateEntered!, payee: payee, memo: memo)
        } else {
            delegate?.updateExpense(amount: -amount, category: category!, date: dateEntered!, payee: payee, memo: memo)
        }
        
        let _ = navigationController?.popViewController(animated: true)
    }
    
    private func flashInvalidField( view: UIView? ) {
        if view == nil {
            return
        }
        UIView.animate(withDuration: 1) {
            let oldColor = view!.backgroundColor
            view!.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
            UIView.animate(withDuration: 1) {
                view!.backgroundColor = oldColor
            }
        }
    }
    
    @IBOutlet weak var amountField: UITextField!
    @IBOutlet weak var selectedCategoryLabel: UILabel!
    @IBOutlet weak var selectedPayeeLabel: UILabel!
    @IBOutlet weak var selectedDateLabel: UILabel!
    @IBOutlet weak var saveButton: UIButton!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        selectedPayeeLabel.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        selectedCategoryLabel.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        
        dateEntered = Date()
        
        updateFields()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        updateFields()
    }
    
    // Initialize properties that hold the expense-related objects from the editExpense
    private func updateFields() {
        if editExpense == nil {
            return
        }
        
        if editExpense!.date != nil {
            dateEntered = (editExpense!.date as! Date)
        }
        
        amountField?.text = String(editExpense!.amount * -1)
        category = editExpense!.category
        payee = editExpense!.payee
        amount = editExpense!.amount
        memo = editExpense!.memo
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    func payeeWasSelected(_ selectedPayee: Payee) {
        // TODO unset payee when the same one is selected
        payee = selectedPayee
        editExpense?.payee = selectedPayee
        
        initializeCategoryForPayee(payee: selectedPayee)
    }
    
    private func initializeCategoryForPayee( payee: Payee ) {
        if category != nil {
            return
        }
        let lastExpenseWithThatPayee = appDelegate.expenseRessource.getFirstByPayee(payee: payee)
        if lastExpenseWithThatPayee == nil {
            return
        }
        category = lastExpenseWithThatPayee?.category
        editExpense?.category = lastExpenseWithThatPayee?.category
    }
    
    func categoryWasSelected(_ selectedCategory: Category) {
        category = selectedCategory
        editExpense?.category = selectedCategory
    }
    
    func dateWasSelected(_ selectedDate: Date) {
        dateEntered = selectedDate
        editExpense?.date = selectedDate as NSDate?
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "selectPayee" {
            let dst = segue.destination as! PayeeViewController
            dst.payeeSelectionDelegate = self
        }
        
        if segue.identifier == "selectCategory" {
            let dst = segue.destination as! CategoryViewController
            dst.categorySelectionDelegate = self
        }
        
        if segue.identifier == "selectDate" {
            let dst = segue.destination as! DateSelectionViewController
            dst.dateSelectionDelegate = self
            if dateEntered != nil {
                dst.startDate = dateEntered!
            }
        }
        
    }

}
