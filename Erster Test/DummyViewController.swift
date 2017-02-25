//
//  DummyViewController.swift
//  Erster Test
//
//  Created by Gabriel Birke on 25.02.17.
//  Copyright © 2017 Gabriel Birke. All rights reserved.
//

import UIKit

class DummyViewController: UIViewController, PayeeSelectionDelegate {

    @IBOutlet weak var payeeNameText: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func payeeWasSelected(_ payee: Payee) {
        payeeNameText?.text = payee.name
        payeeNameText?.isHidden = false
    }

    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "selectPayee" {
            let dst = segue.destination as! PayeeViewController
            dst.payeeSelectionDelegate = self
        }
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

}




