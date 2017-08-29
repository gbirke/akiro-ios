//
//  ExpenseListViewController.swift
//  Erster Test
//
//  Created by Gabriel Birke on 25.02.17.
//  Copyright © 2017 Gabriel Birke. All rights reserved.
//

import UIKit

class ExpenseListViewController: UITableViewController, ExpenseDelegate {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var expenses: [Expense] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    var expenseToBeUpdated: Expense?
    var rowToBeUpdated: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        expenses = appDelegate.expenseRessource.getList();
                
        tableView.register(UINib(nibName: "ExpenseViewCell", bundle: nil), forCellReuseIdentifier: "expenseCell")

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

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return expenses.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "expenseCell", for: indexPath) as! ExpenseViewCell

        cell.expense = expenses[indexPath.row]

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        expenseToBeUpdated = expenses[indexPath.row]
        rowToBeUpdated = indexPath.row
        self.performSegue(withIdentifier: "editExpense", sender: self)
    }
    
    func addExpense( amount:Float, category: Category, date: Date, payee: Payee?, memo: String? ) {
        let newExpense = appDelegate.expenseRessource.insert(amount: amount, category: category, date: date, payee: payee, memo: memo)
        expenses.insert(newExpense, at: 0)
        let _ = navigationController?.popViewController(animated: true)
    }
    
    func updateExpense( amount: Float, category: Category, date: Date, payee: Payee?, memo: String? ) {
        let expense = appDelegate.expenseRessource.update(expense: expenseToBeUpdated!, amount: amount, category: category, date: date, payee: payee, memo: memo )
        expenses[rowToBeUpdated!] = expense
        let _ = navigationController?.popViewController(animated: true)
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addExpense" {
            let dst = segue.destination as! AmountViewController
            dst.delegate = self
            dst.editExpense = nil
        }
        
        if segue.identifier == "editExpense" {
            let dst = segue.destination as! ExpenseEntryViewController
            dst.delegate = self
            dst.editExpense = expenseToBeUpdated
        }
    }
    

}
