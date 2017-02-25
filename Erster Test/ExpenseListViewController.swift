//
//  ExpenseListViewController.swift
//  Erster Test
//
//  Created by Gabriel Birke on 25.02.17.
//  Copyright © 2017 Gabriel Birke. All rights reserved.
//

import UIKit

class ExpenseListViewController: UITableViewController {
    
    var expenses: [Expense] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let foodCat = Category(name: "Auswärts essen", parent: "Allgemein")
        let bioCat =  Category(name: "Naturkost", parent: "Allgemein")
        
        let bioPayee1 = Payee(name: "LPG")
        let bioPayee2 = Payee(name: "Denn's")
        let foodPayee = Payee(name: "Sahara")
        
        let now = Date()
        let yesterday = Date(timeIntervalSinceNow: -3600)
        
        expenses = [
            Expense(amount: -20.0, category: bioCat, date: now, payee: bioPayee1, memo:"" ),
            Expense(amount: -3.5, category: foodCat, date: now, payee: foodPayee, memo:"" ),
            Expense(amount: -2.5, category: foodCat, date: now, payee: nil, memo: "Süßigkeiten" ),
            Expense(amount: -4.91, category: bioCat, date: yesterday, payee: bioPayee2, memo:"" ),
            Expense(amount: -3.5, category: foodCat, date: yesterday, payee: foodPayee, memo:"" ),
            Expense(amount: 3.0, category: bioCat, date: yesterday, payee: nil, memo: "Rückgabe Rebecca" ),
        ]
        
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
