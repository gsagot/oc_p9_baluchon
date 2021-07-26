//
//  GradientView.swift
//  Baluchon
//
//  Created by Gilles Sagot on 20/07/2021.
//

import UIKit

class GradientView : UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    convenience init(inView: UIView) {
        let rect = CGRect(x: 0, y: 0, width: inView.frame.width, height: inView.frame.height)
        self.init(frame: rect)
        
        self.layer.insertSublayer(gradient(frame: self.bounds), at:0)
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
    



    
    
}

