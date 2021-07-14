//
//  CurrencyCell.swift
//  Baluchon
//
//  Created by Gilles Sagot on 13/07/2021.
//

import UIKit

class CurrencyCell: UITableViewCell {
    
    var currencyName = UITextView()
    var currencyAmount = UITextView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    }
   
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.backgroundColor = UIColor(white: 1.0, alpha: 0.3)
        
        currencyAmount.frame = CGRect(x:0,y:(self.center.y ) - 30,width:120,height:120)
        currencyAmount.textColor = UIColor.white
        currencyAmount.backgroundColor = UIColor(white: 1, alpha: 0)
        currencyAmount.font = UIFont(name: "HelveticaNeue-Bold", size: 32)
        currencyAmount.isSelectable = false
        self.addSubview(currencyAmount)
        
        currencyName.frame = CGRect(x:0,y:120,width:self.frame.width,height:30)
        currencyName.backgroundColor = UIColor(white: 1, alpha: 0.2)
        currencyName.textColor = UIColor.white
        currencyName.font = UIFont(name: "HelveticaNeue-Bold", size: 14)
        self.addSubview(currencyName)
        
        self.layer.cornerRadius = 10
        
    }
 
        
}
