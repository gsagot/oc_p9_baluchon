//
//  ChangeViewController.swift
//  Baluchon
//
//  Created by Gilles Sagot on 27/06/2021.
//

import UIKit



class CurrencyViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, UITextViewDelegate  {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var currencyView: CurrencyView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.layer.insertSublayer(gradient(frame: self.view.bounds), at:0)

        // Do any additional setup after loading the view.
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        self.view.addGestureRecognizer(tap)
        
        currencyView.amountInDollarText.delegate = self
        
        // This view controller itself will provide the delegate methods and row data for the table view.
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    // Alert Controller
    private func presentUIAlertController(title:String, message:String) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(ac, animated: true, completion: nil)
    }
    
    // Keyboard Hide on tap function
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        currencyView.amountInDollarText.resignFirstResponder()
        let index = (self.tableView.indexPathsForVisibleRows ?? [])
        self.tableView.reloadRows(at: index, with: .automatic)
        
    }
    
    // Keyboard enter
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        currencyView.amountInDollarText.resignFirstResponder()
        let index = (self.tableView.indexPathsForVisibleRows ?? [])
        self.tableView.reloadRows(at: index, with: .automatic)
        return true
    }
    
    // number of rows in table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Settings.shared.currencies.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150.0;//Choose your custom row height
    }
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // create a new cell if needed or reuse an old one
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CurrencyCell
        let  amount = Double(currencyView.amountInDollarText.text ?? "1.0" )
        
        cell.currencyName.text = "  " + Settings.shared.currencies[indexPath.row].name
        cell.currencyAmount.text = " " + String(format:"%.2f ",Settings.shared.currencies[indexPath.row].rate * Double(amount!) ) + "\n" + " "  + Settings.shared.currencies[indexPath.row].code
      
        return cell
    }
    
    func gradient(frame:CGRect) -> CAGradientLayer {
        let layer = CAGradientLayer()
        layer.frame = frame
        layer.startPoint = CGPoint(x: 0.5, y: 0.0)
        layer.endPoint = CGPoint(x: 0.5, y: 1.0)
        layer.colors = [
        UIColor.cyan.cgColor,UIColor.blue.cgColor]
        return layer
    }

}





















/*
class ChangeViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    
    var currencies = ["EUR","CHF","GBP","YEN","CAD","AUD"]
    var picker = UIPickerView()
    var baseButton = UIButton()
    var okButton = UIButton()
    var baseLabel = UILabel()
    var targetLabel = UILabel()
    var amountLabel = UITextView()
    var resultLabel = UILabel()
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // GET CHANGE ---
        /*
        ChangeService.getChange(completionHandler: { (completion, data) in
            if completion == true {
                DispatchQueue.main.async {
                    self.update (rate: data!)
                }
            }
        })
         */
        
        picker.delegate = self
        picker.dataSource = self
        picker.frame = CGRect(x: 0, y: 0, width: 260, height: 50)
        picker.center = self.view.center
        picker.setValue(UIColor.white, forKey: "textColor")
        picker.layer.backgroundColor = UIColor.blue.cgColor
        picker.layer.cornerRadius = 25
        
        baseButton.frame = CGRect(x: 0, y: 0, width: 260, height: 50)
        baseButton.center = self.view.center
        baseButton.center.y = self.view.center.y - 100
        baseButton.setTitle("USD", for: .normal)
        baseButton.titleLabel?.font = UIFont(name: "Arial", size: 22)
        baseButton.backgroundColor = UIColor.blue
        baseButton.layer.cornerRadius = 25
        
        baseLabel.frame = CGRect(x: 0, y: 0, width: 260, height: 50)
        baseLabel.text = "Monnaie utilisée à New York"
        baseLabel.textAlignment = .center
        baseLabel.center = baseButton.center
        baseLabel.center.y = baseButton.center.y - 50
        
        amountLabel.frame = CGRect(x: 0, y: 0, width: 260, height: 50)
        amountLabel.text = "1"
        amountLabel.font = UIFont(name: "Arial", size: 22)
        amountLabel.backgroundColor = UIColor.white
        amountLabel.textAlignment = .center
        amountLabel.center = baseLabel.center
        amountLabel.center.y = baseLabel.center.y - 50
        
        targetLabel.frame = CGRect(x: 0, y: 0, width: 260, height: 50)
        targetLabel.text = "Séléctionner une monnaie"
        targetLabel.textAlignment = .center
        targetLabel.center = picker.center
        targetLabel.center.y = picker.center.y - 50
        
        resultLabel.frame = CGRect(x: 0, y: 0, width: 260, height: 50)
        resultLabel.text = "1"
        resultLabel.font = UIFont(name: "Arial", size: 22)
        resultLabel.backgroundColor = UIColor.white
        resultLabel.textAlignment = .center
        resultLabel.center = picker.center
        resultLabel.center.y = picker.center.y + 80
        
        okButton.frame = CGRect(x: 0, y: 0, width: 260, height: 50)
        okButton.center = resultLabel.center
        okButton.center.y = resultLabel.center.y + 100
        okButton.setTitle("Valider", for: .normal)
        okButton.titleLabel?.font = UIFont(name: "Arial", size: 22)
        okButton.backgroundColor = UIColor.darkGray
        okButton.layer.cornerRadius = 25
        okButton.addTarget(self, action:#selector(self.validateAmount(_:)), for: .touchUpInside)
 
        self.view.addSubview(picker)
        self.view.addSubview(baseButton)
        self.view.addSubview(baseLabel)
        self.view.addSubview(targetLabel)
        self.view.addSubview(amountLabel)
        self.view.addSubview(resultLabel)
        self.view.addSubview(okButton)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        self.view.addGestureRecognizer(tap)
        
        update (rate: 1.19)
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        // handling code
        amountLabel.resignFirstResponder()
    }
    
    @objc func validateAmount(_ sender: UITapGestureRecognizer? = nil) {
        // handling code
        update(rate: 1.19)
    }
    
 
    
    func update(rate: Double) {
        DispatchQueue.main.async {
            let base = Double(self.amountLabel.text!)
            let result = base! * rate
            self.resultLabel.text = "\(result)"
        }
        
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currencies.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return currencies[row]
    }

    
}
 */
