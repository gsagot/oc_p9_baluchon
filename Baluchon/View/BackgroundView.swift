//
//  BackgroundView.swift
//  Baluchon
//
//  Created by Gilles Sagot on 20/07/2021.
//

import UIKit


class BackgroundView : UIImageView {
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
  
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(inView: UIView) {
        // Adapt the size of background to the size of the device
        // Appearance on every device
        let h = inView.bounds.width
        let w = inView.bounds.width * 4
        let rect = CGRect(x: 0, y: inView.bounds.height - h, width: w, height: h)
        self.init(frame: rect)
        
        self.image = UIImage(named: "Skyline2")
        
        
    }
    
    func start(at:CGFloat) {
        // Where Background will start animation
            self.center.x = at
        
    }
    
    // Move Background in x axis
    func move(to:CGFloat) {
        // Where Background will stop animation
        UIView.animate(withDuration: 0.5) {
            self.center.x = to
        }
        // Save value
        
        
        
        
    }
    
    
}
