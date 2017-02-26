//
//  DateSelectionViewController.swift
//  Erster Test
//
//  Created by Gabriel Birke on 26.02.17.
//  Copyright © 2017 Gabriel Birke. All rights reserved.
//

import UIKit

class DateSelectionViewController: UIViewController {
    
    var dateSelectionDelegate: DateSelectionDelegate?
    
    var startDate: Date?

    @IBOutlet weak var dateSelector: UIDatePicker!
    
    @IBAction func okTouched(_ sender: Any) {
        if dateSelectionDelegate != nil {
            dateSelectionDelegate?.dateWasSelected(dateSelector.date)
        }
        let _ = navigationController?.popViewController(animated: true)
    }

    override func viewDidLoad() {
        guard let date = startDate, let selector = dateSelector else {
            return
        }
        selector.date = date
    }
}
