//
//  ViewController.swift
//  QiblaDirection
//
//  Created by Basem Emara on 06/19/2015.
//  Copyright (c) 06/19/2015 Basem Emara. All rights reserved.
//

import UIKit
import QiblaDirection

class ViewController: UIViewController, QiblaDirectionDelegate {
    
    var qibla: QiblaDirection?
    var currentDegrees = 0.0
    
    @IBOutlet var angleLabel: UILabel!
    @IBOutlet var compassImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.qibla = QiblaDirection(delegate: self, askForAuthorizationIfNeeded: true)
        self.qibla?.tryStartUpdating()
    }
    
    func qiblaDirectionNeedsAuthorization() {
        // Authorisation can be handled here.
    }
    
    func qiblaHeadingDidChange(inPoint: Bool, headingAngle: Double) {
        let label = "Qibla in point: \(inPoint) \nHeading angle  \(headingAngle) degree"
        let offSetDegrees = qibla!.angleOfQibla! - headingAngle
        
        angleLabel.text = label
        
        UIView.animateWithDuration(2.0, animations: {
            let oldRadians = self.degreesToRadians(self.currentDegrees)
            let newRadians = self.degreesToRadians(offSetDegrees)
            
            let qiblaAnimation = CABasicAnimation(keyPath: "transform.rotation")
            qiblaAnimation.fromValue = NSNumber(double: oldRadians)
            qiblaAnimation.toValue = NSNumber(double: newRadians)
            qiblaAnimation.duration = 0.2
            
            self.compassImage!.layer.addAnimation(qiblaAnimation, forKey: "qiblaAnimation")
            self.compassImage!.transform = CGAffineTransformMakeRotation(CGFloat(newRadians))
            
            self.currentDegrees = offSetDegrees
        })
        
        println(label)
    }
    
    func qiblaAngleDidChanged(angle: Double) {
        println("Qibla Angle: \(angle) degree")
    }
    
    func radianToDegrees(radians: Double) -> Double {
        return radians * (180.0 / M_PI)
    }
    
    func degreesToRadians(radians: Double) -> Double {
        return radians  / 180.0 * M_PI
    }
    
}

