//
//  DummyViewController.swift
//  Erster Test
//
//  Created by Gabriel Birke on 25.02.17.
//  Copyright © 2017 Gabriel Birke. All rights reserved.
//

import UIKit

class DummyViewController: UIViewController, PayeeSelectionDelegate, CategorySelectionDelegate {

    @IBOutlet weak var payeeNameText: UILabel!
    @IBOutlet weak var categoryNameText: UILabel!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func payeeWasSelected(_ selectedPayee: Payee) {
        payeeNameText?.text = selectedPayee.name
        payeeNameText?.isHidden = false
    }
    
    func categoryWasSelected(_ selectedCategory: Category) {
        categoryNameText?.text = selectedCategory.name
        categoryNameText?.isHidden = false
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
        
    }
    

}




