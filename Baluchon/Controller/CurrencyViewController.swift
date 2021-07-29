//
//  ChangeViewController.swift
//  Baluchon
//
//  Created by Gilles Sagot on 27/06/2021.
//

import UIKit



class CurrencyViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, UITextViewDelegate  {
    
    @IBOutlet var tableView: UITableView!
    
    var currencyView: CurrencyView!
    var background:BackgroundView!
    var bringUpToDateView:UpdateView!

    // MARK: - REQUEST FROM MODEL
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        // Prepare layout and add subviews
        
        let frame = self.view
        let gradientView = GradientView(inView: frame!)
        self.view.addSubview(gradientView)
        self.view.sendSubviewToBack(gradientView)
       
        currencyView = CurrencyView(inView: frame!)
        currencyView.center.y += 30
        self.view.addSubview(currencyView)
        
        background = BackgroundView(inView: frame!)
        self.view.addSubview(background)
        
        bringUpToDateView = UpdateView(inView: frame!)
        self.view.addSubview(bringUpToDateView)
        
        
        // gesture recognizer
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        self.view.addGestureRecognizer(tap)
        
        let updateTap = UITapGestureRecognizer(target: self, action: #selector(self.updateCurrencies(_:)))
        self.bringUpToDateView.refreshButton.addGestureRecognizer(updateTap)
        
        let validationAmountTap = UITapGestureRecognizer(target: self, action: #selector(self.handleValidationForCity(_:)))
        self.currencyView.validationButton.addGestureRecognizer(validationAmountTap)
        
        // This view controller itself will provide the delegate methods and row data for the table view and text
        currencyView.amountInDollarText.delegate = self
        currencyView.amountInDollarText.keyboardType = .numbersAndPunctuation
        tableView.delegate = self
        tableView.dataSource = self
        
        
        // Function
        updateView()
        lastCurrencies()
        
         
    }
    
    // MARK: - ALERT CONTROLLER
    
    private func presentUIAlertController(title:String, message:String) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(ac, animated: true, completion: nil)
    }
    
    // MARK: - PREPARE ANIMATIONS
    
    override func viewWillAppear(_ animated: Bool) {
        background.start(at: CGFloat(Settings.shared.AnimBackgroundPos))
        currencyView.alpha = 0
        tableView.alpha = 0
        bringUpToDateView.alpha = 0
        bringUpToDateView.center.y -= 50
       
    }
    
    // MARK: - LAUNCH ANIMATIONS
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidLoad()
        
        background.move(to: CGFloat(Settings.shared.AnimBackgroundRef ) - self.view.bounds.width )
        anim()
        
    }
    
    func anim() {
        
        UIView.animate(withDuration: 0.5, delay: 0.3, options: [], animations: {
            self.currencyView.alpha = 100
        }, completion: nil)
        
        UIView.animate(withDuration: 0.5, delay: 0.5, options: [], animations: {
            self.tableView.alpha = 100
        }, completion: nil)
        
        UIView.animate(withDuration: 0.5, delay: 0.5, options: [], animations: {
            self.bringUpToDateView.center.y += 50
            self.bringUpToDateView.alpha = 100
        }, completion: nil)
        
        Settings.shared.AnimBackgroundPos = Float(background.center.x)
        
    }
    
    // MARK: - HANDLE INPUTS
    
    // Keyboard Hide on tap function
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        currencyView.amountInDollarText.resignFirstResponder()

    }
    
    @objc func handleValidationForCity(_ sender: UITapGestureRecognizer? = nil) {
        currencyView.amountInDollarText.resignFirstResponder()
        updateView()
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let textFieldText = textField.text,
            let rangeOfTextToReplace = Range(range, in: textFieldText) else {
                return false
        }
        let substringToReplace = textFieldText[rangeOfTextToReplace]
        let count = textFieldText.count - substringToReplace.count + string.count
        return count <= 5
    }
    
    // Keyboard enter
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        currencyView.amountInDollarText.resignFirstResponder()
        updateView()
        return true
    }
    
    
    @objc func updateCurrencies(_ sender: UITapGestureRecognizer? = nil) {
        lastCurrencies()
        
    }
    
    // MARK: - TABLE VIEW UPDATE / LAYOUT
    
    // number of rows in table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Settings.shared.getNumberOfCurrencies()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80;//Choose your custom row height
    }
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // create a new cell if needed or reuse an old one
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CurrencyCell
        let amount = Double(currencyView.amountInDollarText.text ?? "10")
        
        // read value at index
        let rate = Settings.shared.readCurrency(at: indexPath.row).rate
        let code = Settings.shared.readCurrency(at: indexPath.row).code
        let icon = Settings.shared.readCurrency(at: indexPath.row).icon
        
        // Layout cell with tableView
        cell.currencyImage.center.x = tableView.frame.width - 30
        
        // Anim
        cell.currencyImage.animationImages = animatedImages(for: icon)
        cell.currencyImage.animationDuration = 0.9
        cell.currencyImage.animationRepeatCount = .zero
        cell.currencyImage.image = cell.currencyImage.animationImages?.first
        cell.currencyImage.startAnimating()
        
        // Update Amount 
        cell.currencyAmount.text = " " + String(format:"%.2f ",rate * Double(0) ) + " "  + code

        guard amount != nil else {return cell}
        cell.currencyAmount.text = " " + String(format:"%.2f ",rate * Double(amount!) ) + " "  + code
        
        return cell
    }
    
    // This could be usefull
    /*
     func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
     self.tableView.reloadRows(at: [indexPath], with: .automatic)
     }
     */
    
    // MARK: - REQUEST FROM MODEL
    
    func lastCurrencies() {
        startActivity()
        
        CurrencyService.shared.getRate(completionHandler: { (success, error, current) in
                                        if success == true {
                                            Settings.shared.saveRate(from: current!)
                                            self.stopActivity()
                                            self.updateView()
                                        }
                                        else {
                                            self.stopActivity()
                                            self.presentUIAlertController(title: Settings.shared.errorTitle, message: error!)
                                            
                                        }})
        

        
    }
    
    // MARK: - UPDATE VIEW
    
    func updateView() {
        let value = currencyView.amountInDollarText.text ?? " "
        
        self.bringUpToDateView.lastUpdateText.text = Settings.shared.readCurrency(at: 0).date
        
        if Double(value) != nil {
            let index = (self.tableView.indexPathsForVisibleRows ?? [])
            self.tableView.reloadRows(at: index, with: .automatic)
            
        }
        else {
            let index = (self.tableView.indexPathsForVisibleRows ?? [])
            self.tableView.reloadRows(at: index, with: .automatic)
            presentUIAlertController(title:Settings.shared.errorTitle, message: Settings.shared.errorTyping)
            
        }
        
    }
    
    func startActivity () {
        bringUpToDateView.indicator.startAnimating()
        bringUpToDateView.refreshButton.isHidden = true
  
    }
    
    func stopActivity () {
        bringUpToDateView.indicator.stopAnimating()
        bringUpToDateView.refreshButton.isHidden = false
  
    }
    
    // MARK: - UTILS
    
    func animatedImages(for name: String) -> [UIImage] {
        
        var i = 0
        var images = [UIImage]()
        
        while let image = UIImage(named: "\(name)_\(i)") {
            images.append(image)
            i += 1
        }
        return images
    }
    
}
