//
//  CurrencyCell.swift
//  Baluchon
//
//  Created by Gilles Sagot on 13/07/2021.
//

import UIKit

class CurrencyCell: UITableViewCell {
    
    let currencyName = UITextView()
    let currencyAmount = UITextView()
    let currencyImage = UIImageView()

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
   
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        self.selectionStyle = .none
        
        self.backgroundColor = UIColor (red: 0, green: 0, blue: 1, alpha: 0)
        currencyAmount.frame = CGRect(x:0,y:0,width:240,height:40)
        currencyAmount.textColor = UIColor.white
        currencyAmount.backgroundColor = UIColor(white: 1, alpha: 0)
        currencyAmount.font = UIFont(name: "HelveticaNeue-Bold", size: 30)
        currencyAmount.isSelectable = false
        currencyAmount.isScrollEnabled = false
       
        self.addSubview(currencyAmount)
        
        currencyName.frame = CGRect(x:0,y:currencyAmount.frame.maxY,width:self.frame.width,height:30)
        currencyName.textColor = UIColor.white
        currencyName.backgroundColor = UIColor(white: 1, alpha: 0)
        currencyName.font = UIFont(name: "HelveticaNeue-Bold", size: 14)
        currencyName.isSelectable = false
        currencyName.isScrollEnabled = false
        self.addSubview(currencyName)
        
        
  
        currencyImage.frame = CGRect(x:0,y:10,width:60,height:60)
        self.addSubview(currencyImage)
       
        
    }
    


    

    
 
    
 
 
        
}
