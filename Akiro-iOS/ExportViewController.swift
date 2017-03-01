//
//  ExportViewController.swift
//  Akiro-iOS
//
//  Created by Gabriel Birke on 28.02.17.
//  Copyright © 2017 Gabriel Birke. All rights reserved.
//

import UIKit
import MessageUI

class ExportViewController: UITableViewController, MFMailComposeViewControllerDelegate {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    let LAST_EXPORT_KEY = "last_export"
    

    @IBOutlet weak var lastExportLabel: UILabel!
    @IBOutlet weak var allExpensesCountLabel: UILabel!
    @IBOutlet weak var newExpensesCountLabel: UILabel!
    
    @IBAction func exportNew(_ sender: Any) {
        let lastExport:Date? = UserDefaults.standard.object(forKey: LAST_EXPORT_KEY) as? Date
        var exportString = ""
        let exportDate = Date()
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        
        if lastExport == nil {
            return
        }
        
        for expense in appDelegate.expenseRessource.getList(startDate: lastExport!) {
            exportString += CSVColumns(fromExpense: expense, dateFormat: formatter).joined(separator: ",") +  "\n"
        }
        writeToFile(fromString: exportString, withName: getExportName(prefix: "export_", exportDate: exportDate))
        UserDefaults.standard.set(exportDate, forKey: LAST_EXPORT_KEY)
        updateLabels()
    }
    
    @IBAction func exportAll(_ sender: Any) {
        var exportString = ""
        let exportDate = Date()
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        
        for expense in appDelegate.expenseRessource.getList() {
            exportString += CSVColumns(fromExpense: expense, dateFormat: formatter).joined(separator: ",") +  "\n"
        }
        writeToFile(fromString: exportString, withName: getExportName(prefix: "export_all_", exportDate: exportDate))
        UserDefaults.standard.set(exportDate, forKey: LAST_EXPORT_KEY)
        updateLabels()
    }
    
    private func CSVColumns( fromExpense: Expense, dateFormat: DateFormatter ) -> [String] {
        var dateEntered: String
        if fromExpense.date == nil {
            dateEntered = ""
        } else {
            dateEntered = dateFormat.string(from: fromExpense.date! as Date)
        }
        
        return [
            fromExpense.amount.description,
            dateEntered,
            fromExpense.category?.parent ?? "",
            fromExpense.category?.name ?? "",
            fromExpense.payee?.name ?? "",
            fromExpense.memo ?? ""
        ]
    }
    
    private func getExportName( prefix: String, exportDate: Date ) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMddHHmmss"
        return prefix + formatter.string(from: exportDate) + ".csv"
        
    }
    
    private func writeToFile( fromString: String, withName: String ) {
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            
            let path = dir.appendingPathComponent(withName)
            
            // For debugging and finding it in simulator
            print("saving to \(path)")
            
            //writing
            do {
                try fromString.write(to: path, atomically: false, encoding: String.Encoding.utf8)
            }
            catch {
                print("could not write export file\n\(error)")
            }
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController,
                               didFinishWith result: MFMailComposeResult, error: Error?) {
        // TODO check result, write last export date if resolu is success
        controller.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateLabels()

        // Do any additional setup after loading the view.
    }
    
    private func updateLabels() {
        let lastExport:Date? = UserDefaults.standard.object(forKey: LAST_EXPORT_KEY) as? Date
        
        if lastExport != nil {
            let formatter = DateFormatter()
            formatter.dateStyle = .short
            formatter.timeStyle = .short
            lastExportLabel.text = formatter.string(from: lastExport!)
        } else {
            lastExportLabel.text = "Never"
        }
        
        allExpensesCountLabel.text = String(appDelegate.expenseRessource.getCount())
        if lastExport == nil {
           newExpensesCountLabel.text = String(appDelegate.expenseRessource.getCount())
        } else {
            newExpensesCountLabel.text = String(appDelegate.expenseRessource.getCount(startDate: lastExport!))
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        updateLabels()
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
