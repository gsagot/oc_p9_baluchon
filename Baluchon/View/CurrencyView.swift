//
//  CurrencyView.swift
//  Baluchon
//
//  Created by Gilles Sagot on 13/07/2021.
//

import UIKit

class CurrencyView: UIView {
    
    var amountInDollarText = UITextField()
    var currencyCodeText = UITextView()
    var explenationText = UITextView()
    var validationButton = UIButton()
    var borderView = UIView()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.backgroundColor = UIColor(white: 1.0, alpha: 0.0)
        
        borderView.frame = CGRect(x:0,y:120,width:240,height:4)
        borderView.center.x = self.center.x
        borderView.backgroundColor = UIColor(white: 1, alpha: 1.0)
        self.addSubview(borderView)
        
        amountInDollarText.frame = CGRect(x:10,y:10,width:240,height:40)
        amountInDollarText.textColor = UIColor.white
        amountInDollarText.backgroundColor = UIColor(white: 1, alpha: 0.0)
        amountInDollarText.font = UIFont(name: "HelveticaNeue-Bold", size: 50)
        amountInDollarText.text = "10.0"
        amountInDollarText.layer.cornerRadius = 10
        self.addSubview(amountInDollarText)
        
        validationButton.frame = CGRect(x:self.frame.width - 200,y:(self.center.y ) - 95,width:60,height:60)
        //validationButton.backgroundColor = UIColor(white: 1, alpha: 1.0)
        validationButton.setBackgroundImage(UIImage(systemName: "checkmark.rectangle"), for: .normal)
        validationButton.tintColor = UIColor.white
        //self.addSubview(validationButton)
        
        currencyCodeText.frame = amountInDollarText.frame.offsetBy(dx: 0, dy: 50)
        currencyCodeText.textColor = UIColor.white
        currencyCodeText.backgroundColor = UIColor(white: 1, alpha: 0.0)
        currencyCodeText.font = UIFont(name: "HelveticaNeue-Bold", size: 32)
        currencyCodeText.text = "EUR"
        self.addSubview(currencyCodeText)
        
        explenationText.frame = CGRect(x:10,y:0,width:self.frame.width,height:100)
        explenationText.textColor = UIColor.white
        explenationText.backgroundColor = UIColor(white: 1, alpha: 0.0)
        explenationText.font = UIFont(name: "HelveticaNeue-Bold", size: 22)
        explenationText.text = "montant en euro à convertir : "
        //self.addSubview(explenationText)
        
        
    }
    
}
