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
    
    var background = UIImageView()
    var screen = CGRect()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*
        ChangeService.shared.getChange(completionHandler: { (success, error, current) in
            if success == true {
                ...
            }
            else {
                self.presentUIAlertController(title: "Error", message: error!)
                
            } })
         */
       
        backgroundInit()
        self.view.addSubview(background)
        self.view.sendSubviewToBack(background)
        
        self.view.layer.insertSublayer(gradient(frame: self.view.bounds), at:0)

        // Do any additional setup after loading the view.
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        self.view.addGestureRecognizer(tap)
        
        currencyView.amountInDollarText.delegate = self
        
        // This view controller itself will provide the delegate methods and row data for the table view.
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        background.center.x = CGFloat(Settings.shared.posx)
        currencyView.alpha = 0
        tableView.alpha = 0
    }

    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidLoad()
        
        backgroundAnim()
        
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
        let value = currencyView.amountInDollarText.text ?? " "

        if Double(value) != nil {
            let index = (self.tableView.indexPathsForVisibleRows ?? [])
            self.tableView.reloadRows(at: index, with: .automatic)
        }
        else {
            presentUIAlertController(title:"error", message: Settings.shared.errorTyping)
            
        }

        
    }
    
    // Keyboard enter
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        currencyView.amountInDollarText.resignFirstResponder()
        let value = currencyView.amountInDollarText.text ?? " "
        
        if Double(value) != nil {
            let index = (self.tableView.indexPathsForVisibleRows ?? [])
            self.tableView.reloadRows(at: index, with: .automatic)
        }
        else {
            presentUIAlertController(title:"error", message: Settings.shared.errorTyping)
                
        }
        return true
    }
    
    // number of rows in table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Settings.shared.currencies.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80;//Choose your custom row height
    }
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // create a new cell if needed or reuse an old one
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CurrencyCell
        let  amount = Double(currencyView.amountInDollarText.text ?? "1.0" )
        
        cell.currencyName.text = "  " + Settings.shared.currencies[indexPath.row].name
        cell.currencyAmount.text = " " + String(format:"%.2f ",Settings.shared.currencies[indexPath.row].rate * Double(amount!) ) + " "  + Settings.shared.currencies[indexPath.row].code
      
        return cell
    }
    
    func gradient(frame:CGRect) -> CAGradientLayer {

        let layer = CAGradientLayer()
        layer.frame = frame
        layer.startPoint = CGPoint(x: 0.5, y: 0.0)
        layer.endPoint = CGPoint(x: 0.5, y: 1.0)
        let baseColor = UIColor(red: (80/255), green: (141/255), blue: (196/255), alpha: 1 * (255/255))
        let lightColor = modifie(color: baseColor, withAdditionalHue: 0, additionalSaturation: 0, additionalBrightness: 0.4)
        layer.colors = [baseColor.cgColor,lightColor.cgColor]
        
        return layer
    }
    
    func modifie(color: UIColor, withAdditionalHue hue: CGFloat, additionalSaturation: CGFloat, additionalBrightness: CGFloat) -> UIColor {

        var currentHue: CGFloat = 0.0
        var currentSaturation: CGFloat = 0.0
        var currentBrigthness: CGFloat = 0.0
        var currentAlpha: CGFloat = 0.0

        if color.getHue(&currentHue, saturation: &currentSaturation, brightness: &currentBrigthness, alpha: &currentAlpha){
            return UIColor(hue: currentHue + hue,
                           saturation: currentSaturation + additionalSaturation,
                           brightness: currentBrigthness + additionalBrightness,
                           alpha: currentAlpha)
        } else {
            return color
        }
    }
    
    
    func backgroundInit() {
        
        screen = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        
        background.frame = CGRect(x: 0, y: screen.height - screen.width, width:screen.width * 3 , height: screen.width )
        background.image = UIImage(named: "Skyline")
        
        Settings.shared.posx = Float(background.center.x)
        Settings.shared.refX = Float(background.center.x)
        
        
    }
    
    func backgroundAnim() {
        
        UIView.animate(withDuration: 0.5) {
            self.background.center.x = CGFloat(Settings.shared.refX) - self.view.bounds.width
        }
        
        UIView.animate(withDuration: 0.5, delay: 0.3, options: [], animations: {
            self.currencyView.alpha = 100
        }, completion: nil)
        
        UIView.animate(withDuration: 0.5, delay: 0.5, options: [], animations: {
            self.tableView.alpha = 100
        }, completion: nil)
        
        Settings.shared.posx = Float(background.center.x)
        
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
