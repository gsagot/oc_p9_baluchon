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
    
    func reference (this:CGFloat){
        // Point reference for anim : this value is set once by first controller
        // Controllers will call this point reference and add values (view.width)
        // The value is stored in a singleton class ; Then controllers can access
        Settings.shared.refX = Float(this)
        // Point reference : have the background position from previous Controller
        // This value is set everytime a controller finished animation
        Settings.shared.posx = Float(this)
    }
    
    
    func start(at:CGFloat) {
        // Where Background will start animation
            self.center.x = at
        
    }
    
    // Move Background in x axis
    func translate(to:CGFloat) {
        // Where Background will stop animation
        UIView.animate(withDuration: 0.5) {
            self.center.x = to
        }
        // Save value
        Settings.shared.posx = Float(self.center.x)
        
        
        
    }
    
    
}
