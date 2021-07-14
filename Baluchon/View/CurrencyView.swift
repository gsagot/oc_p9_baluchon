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
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.backgroundColor = UIColor(white: 1.0, alpha: 0.8)
        
        amountInDollarText.frame = CGRect(x:10,y:(self.center.y ) - 100,width:120,height:50)
        //amountInDollarText.textColor = UIColor.white
        amountInDollarText.backgroundColor = UIColor(white: 1, alpha: 1)
        amountInDollarText.font = UIFont(name: "Arial", size: 32)
        amountInDollarText.text = "10.0"
        amountInDollarText.layer.cornerRadius = 10
        self.addSubview(amountInDollarText)
        
      
        
        currencyCodeText.frame = amountInDollarText.frame.offsetBy(dx: 0, dy: 42)
        //currencyCodeText.textColor = UIColor.white
        currencyCodeText.backgroundColor = UIColor(white: 1, alpha: 0.0)
        currencyCodeText.font = UIFont(name: "Arial", size: 32)
        currencyCodeText.text = "EUR"
        self.addSubview(currencyCodeText)
        
        explenationText.frame = CGRect(x:10,y:0,width:self.frame.width,height:100)
        //explenationText.textColor = UIColor.white
        explenationText.backgroundColor = UIColor(white: 1, alpha: 0.0)
        explenationText.font = UIFont(name: "Arial", size: 22)
        explenationText.text = "montant à convertir : "
        //self.addSubview(explenationText)
         
        
        self.layer.cornerRadius = 10
        
        
    }
    
}
