//
//  QiblaDirectionDelegate.swift
//  Qibla
//
//  Created by Ethem Ozcan on 02/05/15.
//  Copyright (c) 2015 Ethem Ozcan. All rights reserved.
//

import Foundation
import CoreLocation

public protocol QiblaDirectionDelegate: class {
    func qiblaDirectionNeedsAuthorization()
    func qiblaAngleDidChanged(angle: Double)
    func qiblaHeadingDidChange(inPoint: Bool, headingAngle: Double)
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!)
    func locationManager(manager: CLLocationManager!, didUpdateHeading newHeading: CLHeading!)
}

public extension QiblaDirectionDelegate {
    
    // Simulate optionals without obj-c
    func qiblaDirectionNeedsAuthorization() {}
    func qiblaAngleDidChanged(angle: Double) {}
    func qiblaHeadingDidChange(inPoint: Bool, headingAngle: Double) {}
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {}
    func locationManager(manager: CLLocationManager!, didUpdateHeading newHeading: CLHeading!) {}
    
}