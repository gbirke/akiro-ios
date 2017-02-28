//
//  ExportViewController.swift
//  Akiro-iOS
//
//  Created by Gabriel Birke on 28.02.17.
//  Copyright © 2017 Gabriel Birke. All rights reserved.
//

import UIKit
import MessageUI

class ExportViewController: UIViewController, MFMailComposeViewControllerDelegate {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    

    @IBOutlet weak var lastExportLabel: UILabel!
    
    @IBAction func exportNew(_ sender: Any) {
        let alertController = UIAlertController(title: "Error", message:
            "Not implemented yet!", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
        
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    @IBAction func exportAll(_ sender: Any) {
        var exportString = ""
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        
        for expense in appDelegate.expenseRessource.getList() {
            exportString += CSVColumns(fromExpense: expense, dateFormat: formatter).joined(separator: ",") +  "\n"
        }
        writeToFile(fromString: exportString)
        lastExportLabel?.text = formatter.string(from: Date())
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
    
    private func writeToFile( fromString: String ) {
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            
            let path = dir.appendingPathComponent("export.csv")
            
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

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
