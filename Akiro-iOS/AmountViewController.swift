//
//  AmountViewController.swift
//  Akiro-iOS
//
//  Created by Gabriel Birke on 29.08.17.
//  Copyright © 2017 Gabriel Birke. All rights reserved.
//

import UIKit

class AmountViewController: UIViewController {
    
    let formatter = NumberFormatter()
    
    var amount = 0 {
        didSet {
            amountDisplay.text = formatter.string(from: NSNumber(value: Float(amount) / 100))
        }
    };

    @IBOutlet weak var amountDisplay: UILabel!
    
    @IBAction func numberTapped(_ sender: Any) {
        guard let button = sender as? UIButton else {
            return
        }
        amount = amount * 10 + button.tag
    }
    
    @IBAction func deleteTapped(_ sender: Any) {
        amount /= 10
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        formatter.numberStyle = .currency

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
