//
//  RefreshView.swift
//  Baluchon
//
//  Created by Gilles Sagot on 25/07/2021.
//

import UIKit

class RefreshView : UIView {
    
    var refreshButton = UIButton()
    var lastUpdateText = UITextField()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(inView: UIView) {
 
        
        let rect = CGRect(x: 0, y: 0, width: inView.frame.width, height: 60)
        self.init(frame: rect)
        
        self.center.x = inView.center.x
        
        lastUpdateText.frame = CGRect(x: 0, y: 0, width: 140, height: 30)
        lastUpdateText.center.x = inView.center.x
        lastUpdateText.center.y += 40
        lastUpdateText.font = UIFont(name: "HelveticaNeue", size: 16)
        lastUpdateText.textColor = UIColor.white
        lastUpdateText.textAlignment = .center
        self.addSubview(lastUpdateText)
        
        
        let image = UIImage(systemName: "arrow.clockwise.circle.fill")
        refreshButton.frame = CGRect(x: lastUpdateText.frame.maxX + 15, y: 40, width: 30, height: 30)
        refreshButton.tintColor = UIColor.white
        refreshButton.setBackgroundImage(image, for: .normal)
        
        self.addSubview(refreshButton)
        
        
        
        
      
          
    }
}
