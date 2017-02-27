//
//  PayeeViewController.swift
//  Erster Test
//
//  Created by Gabriel Birke on 25.02.17.
//  Copyright © 2017 Gabriel Birke. All rights reserved.
//

import UIKit

class PayeeViewController: UITableViewController, UISearchResultsUpdating {
    
    var payees: [Payee] = [] {
        didSet {
            self.tableView.reloadData()
        }
    }
    var filteredPayees = [Payee]()
    
    let searchController = UISearchController(searchResultsController: nil)
    
    var delegate: PayeeDelegate?
    var payeeSelectionDelegate: PayeeSelectionDelegate?
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        payees = appDelegate.payeeRessource.getList()
        
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        
        delegate = self
        
        // See http://stackoverflow.com/questions/32675001/uisearchcontroller-warning-attempting-to-load-the-view-of-a-view-controller
        searchController.loadViewIfNeeded()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive && searchController.searchBar.text != "" {
            return filteredPayees.count + 1
        }
        return payees.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "payeeCell", for: indexPath)
        
        if searchController.isActive && searchController.searchBar.text != "" {
            if indexPath.row > 0 {
                cell.textLabel?.text = filteredPayees[indexPath.row-1].name
            } else {
                cell.textLabel?.text = "Create \"\(searchController.searchBar.text!)\" payee"
                cell.textLabel?.textColor = UIColor(red:0.09, green:0.81, blue:0.11, alpha:1.0) // green tint
            }
            
        } else {
            cell.textLabel?.text = payees[indexPath.row].name
            cell.textLabel?.textColor = nil // Reset color to avoid 1st item being green when it's reused.
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if searchController.isActive && searchController.searchBar.text != "" {
            if indexPath.row > 0 {
                payeeSelectionDelegate?.payeeWasSelected(filteredPayees[indexPath.row-1])
            } else {
                if let payee = delegate?.addPayee(withName: searchController.searchBar.text!) {
                    payees.append(payee)
                    payeeSelectionDelegate?.payeeWasSelected(payee)
                }
                
            }
        } else {
            payeeSelectionDelegate?.payeeWasSelected(payees[indexPath.row])
        }
    
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



    // MARK: - Search results
    
    func filterContentForSearchText(searchText: String, scope: String = "All") {
        filteredPayees = payees.filter { payee in
            guard let name = payee.name else {
                return false
            }
            return name.lowercased().contains(searchText.lowercased())
        }

        tableView.reloadData()
    }
    
    public func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchText: searchController.searchBar.text!)
    }
   
}

// MARK: - PayeeDelegate

extension PayeeViewController: PayeeDelegate {
    func addPayee(withName: String) -> Payee {
        return appDelegate.payeeRessource.insert(withName: withName)
    }
    
}


