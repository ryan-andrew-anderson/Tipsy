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
    @IBOutlet weak var fifteenPctButton: UIButton!
    @IBOutlet weak var twentyPctButton: UIButton!
    @IBOutlet weak var splitNumberLabel: UILabel!
    
    var tip = Tip()
    var brain = TipBrain()
    
    @IBAction func tipChanged(_ sender: UIButton) {
        
        guard let text = billTextField.text, text != "", let tipTitle = sender.currentTitle else { return }
        
        billTextField.resignFirstResponder()
        zeroPctButton.isSelected = false
        tenPctButton.isSelected = false
        fifteenPctButton.isSelected = false
        twentyPctButton.isSelected = false
        
        sender.isSelected = true
        
        tip.total = Double(text)!
         tip.tipText = tipTitle
        
        self.tip.tipPct = brain.getPctFromString(tipTitle)
        print(self.tip.tipPct)
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        splitNumberLabel.text = String(format: "%.0f", sender.value)
        tip.theSplit = Double(sender.value)
    }
    
    @IBAction func calculatePressed(_ sender: UIButton) {
        let bill = billTextField.text
        
        if bill != "" {
 
            tip.totalPerPerson =
            brain.calculateTotal(total: tip.total, tipPct: tip.tipPct, theSplit: tip.theSplit)
            performSegue(withIdentifier: "nextSlide", sender: self)
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "nextSlide" {
            let vc = segue.destination as! ResultsViewController
            vc.total = String(format: "%.2f", tip.totalPerPerson)
            vc.setting = "Split between \(Int(tip.theSplit)), with \(tip.tipText ?? "") tip."
        }
    }
}
