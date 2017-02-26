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
    private var category: Category?
    private var payee: Payee?
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
    
    var delegate: ExpenseDelegate?

    @IBAction func amountEntered(_ sender: UITextField) {
        if let textEntered = sender.text, let convertedAmount = Float(textEntered.replacingOccurrences(of: ",", with: ".")) { // Crude float conversion for german numbers until we have fancy amount input
            amount = convertedAmount
        }
    }
    
    @IBAction func saveTouched(_ sender: Any) {
        if amount > 0 && category != nil && dateEntered != nil {
            delegate?.addExpense(amount: -amount, category: category!, date: dateEntered!, payee: payee, memo: memo)
            let _ = navigationController?.popViewController(animated: true)
        } else {
            guard let button = self.saveButton else {
                return;
            }
            UIView.animate(withDuration: 1) {
                let oldColor = button.backgroundColor
                button.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
                UIView.animate(withDuration: 1) {
                    button.backgroundColor = oldColor
                }
            }
        }
    }
    
    @IBOutlet weak var selectedCategoryLabel: UILabel!
    @IBOutlet weak var selectedPayeeLabel: UILabel!
    @IBOutlet weak var selectedDateLabel: UILabel!
    @IBOutlet weak var saveButton: UIButton!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        selectedPayeeLabel.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        selectedCategoryLabel.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        
        dateEntered = Date()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    func payeeWasSelected(_ selectedPayee: Payee) {
        // TODO unset payee when the same one is selected
        payee = selectedPayee
        selectedPayeeLabel.text = selectedPayee.name
        selectedPayeeLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }
    
    func categoryWasSelected(_ selectedCategory: Category) {
        category = selectedCategory
        selectedCategoryLabel.text = selectedCategory.name
        selectedCategoryLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }
    
    func dateWasSelected(_ selectedDate: Date) {
        dateEntered = selectedDate
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
