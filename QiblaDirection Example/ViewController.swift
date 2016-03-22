//
//  FirstViewController.swift
//  QiblaDirection Example
//
//  Created by Basem Emara on 3/22/16.
//
//

import UIKit
import CoreLocation

class ViewController: UIViewController, QiblaDirectionDelegate {
    
    var qibla: QiblaDirection?
    var currentDegrees = 0.0

    @IBOutlet weak var compassImage: UIImageView!
    @IBOutlet weak var angleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.qibla = QiblaDirection(delegate: self, askForAuthorizationIfNeeded: true)
        self.qibla?.tryStartUpdating()
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
        
        print(label)
    }
    
    func radianToDegrees(radians: Double) -> Double {
        return radians * (180.0 / M_PI)
    }
    
    func degreesToRadians(radians: Double) -> Double {
        return radians  / 180.0 * M_PI
    }
    
    func qiblaAngleDidChanged(angle: Double) {
        print("Qibla Angle: \(angle) degree")
    }
    
    func qiblaDirectionNeedsAuthorization() {
        // Authorisation can be handled here.
        print("qiblaDirectionNeedsAuthorization")
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        print("locationManager.didUpdateLocations \(locations)")
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateHeading newHeading: CLHeading!) {
        print("locationManager.didUpdateHeading \(newHeading)")
    }
    
}