//
//  CategoryViewController.swift
//  Erster Test
//
//  Created by Gabriel Birke on 25.02.17.
//  Copyright © 2017 Gabriel Birke. All rights reserved.
//

import UIKit

class CategoryViewController: UITableViewController {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var categories: [Category] = []
    var categoryIndex: [[Int]] = []
    
    var categorySelectionDelegate: CategorySelectionDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initCategoriesFromList()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    private func initCategoriesFromList() {
        categories = appDelegate.categoryRessource.getList()
        var currentSection = ""
        var sectionIndices = [String: Int]()
        for (index, category) in categories.enumerated() {
            if sectionIndices[category.parent] == nil {
                currentSection = category.parent
                sectionIndices[currentSection] = sectionIndices.count
                categoryIndex.append([index])
            } else {
                categoryIndex[sectionIndices[currentSection]!].append(index)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return categoryIndex.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return categoryIndex[section].count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath)

        cell.textLabel?.text = categories[categoryIndex[indexPath.section][indexPath.row]].name

        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return categories[categoryIndex[section][0]].name
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        categorySelectionDelegate?.categoryWasSelected(categories[categoryIndex[indexPath.section][indexPath.row]])
        let _ = navigationController?.popViewController(animated: true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
