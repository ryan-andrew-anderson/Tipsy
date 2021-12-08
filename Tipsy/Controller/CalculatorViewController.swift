//
//  ViewController.swift
//  Tipsy
//
//  Created by Angela Yu on 09/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {
    
    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var zeroPctButton: UIButton!
    @IBOutlet weak var tenPctButton: UIButton!
    @IBOutlet weak var twentyPctButton: UIButton!
    @IBOutlet weak var splitNumberLabel: UILabel!
    
    
    var total = 0.00
    var tipPct = 0.00
    var theSplit = 2.00
    var totalPerPerson = 0.00
    var tipText : String?
    
    @IBAction func tipChanged(_ sender: UIButton) {
        
        guard let text = billTextField.text, text != "", let tipTitle = sender.currentTitle else { return }
        total = Double(text)!
        //        billTextField.endEditing(true)
        billTextField.resignFirstResponder()
        zeroPctButton.isSelected = false
        tenPctButton.isSelected = false
        twentyPctButton.isSelected = false
        
        sender.isSelected = true
        
         tipText = tipTitle
        let tip = tipTitle.dropLast()
        let tipDouble = Double(tip)!
        
        self.tipPct = tipDouble / 100
        
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        splitNumberLabel.text = String(format: "%.0f", sender.value)
        theSplit = Double(sender.value)
    }
    
    @IBAction func calculatePressed(_ sender: UIButton) {
        let bill = billTextField.text
        
        if bill != "" {
            let totalPlusTip = (total * tipPct) + total
            totalPerPerson = totalPlusTip / theSplit
            print(totalPerPerson)
            print(String(format: "%.2f", totalPerPerson))
            performSegue(withIdentifier: "nextSlide", sender: self)
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "nextSlide" {
            let vc = segue.destination as! ResultsViewController
            vc.total = String(format: "%.2f", totalPerPerson)
            vc.setting = "Split between \(Int(theSplit)), with \(tipText ?? "") tip."
        }
    }
}
