//
//  ViewController.swift
//  CalculadoraPropinasNETEC
//
//  Created by Victor Hugo Benitez Bosques on 21/05/19.
//  Copyright © 2019 Victor Hugo Benitez Bosques. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var strAmountTopay : String?
    var strPercent: String?
    
    @IBOutlet weak var txfAmount: UITextField!{
        didSet{
            txfAmount.delegate = self
        }
    }
    @IBOutlet weak var txfPercent: UITextField!{
        didSet{
            txfPercent.delegate = self
        }
    }
    
    @IBOutlet weak var lblPercentAmount: UILabel!
    @IBOutlet weak var lblTotalAmount: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setDataPickerPercent()
        setUpPickerIntoTxf()
        
    }
    
    func setUpPickerIntoTxf() {
        
        let thePicker = UIPickerView()
        
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        toolBar.sizeToFit()
        
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.plain, target: self, action: #selector(ViewController.donePicker))
        
        
        toolBar.setItems([doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        
        thePicker.delegate = self
        
        txfPercent.inputView = thePicker
        txfPercent.inputAccessoryView = toolBar
        
        txfPercent.inputView = thePicker
        txfPercent.inputAccessoryView = toolBar
        txfAmount.inputAccessoryView = toolBar
    }
    
    @objc func donePicker() {
        
        txfPercent.resignFirstResponder()
        txfAmount.resignFirstResponder()
        
    }

    @IBAction func btnCalcuAction(_ sender: UIButton) {
        
        
        if validateTxf(){
            
            if let amount = Double(strAmountTopay ?? "0"), let propina =  Double(strPercentSelected ?? "0"){
                let propina = amount * (propina / 100)
                let total = amount + propina
                
                print("Total to pay ", total)
                
                lblTotalAmount.text = "\(total)"
                lblPercentAmount.text = "\(propina)"
            }
            
        }else{
            
            addAlert(strTitle: "Actividad 3", strMessage: " Valide que los datos de monto y porcentaje sean mayores a 0")
           
        }
        
        
        
    }
    var arrPercent = [String]()
    func setDataPickerPercent(){
        
        arrPercent = ["10", "15", "20", "25", "30", "35", "40"]
        strPercentSelected = arrPercent[0]
        
    }
    
    
    func addAlert(strTitle : String?, strMessage : String?, bSuccess : Bool = false){
        let alert = UIAlertController(title: strTitle, message: strMessage, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (_) in
            
            if bSuccess{
                DispatchQueue.main.async {
                }
            }
        })
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
    }
    
    func validateTxf() -> Bool{
        if txfAmount.text!.count > 0 && txfPercent.text!.count > 0{
            return true
        }
        return false
    }
    
    
    var bTxfFirst = false
    var bTxfSecond = false
    
    var strPercentSelected : String?
}

extension ViewController : UITextFieldDelegate{
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if textField == txfAmount{
            strAmountTopay = textField.text
        }
        if textField == txfPercent{
            strPercent = textField.text
            txfPercent.text = strPercentSelected
        }
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        bTxfFirst = false
        bTxfSecond = false
        
        if textField.tag == 1 {
            bTxfFirst = true
        }else{
            bTxfSecond = true
        }

        return true
    }
}


extension  ViewController : UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
     func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return arrPercent.count
    }
    
    func pickerView( _ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return arrPercent[row]
    }
    
    func pickerView( _ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if bTxfSecond{
            strPercentSelected = arrPercent[row]
        }
        
    }
    
}

