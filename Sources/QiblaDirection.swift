//
//  QiblaDirection.swift
//  Qibla
//
//  Created by Ethem Ozcan on 02/05/15.
//  Copyright (c) 2015 Ethem Ozcan. All rights reserved.
//

import Foundation
import CoreLocation

public class QiblaDirection: NSObject, CLLocationManagerDelegate {
    
    // MARK: - Constants
    let accurency = 1.5 // as degree
    let lattituteOfMecca = 21.42247
    let longtitueOfMecca = 39.826207
    let shouldDisplayHeadingCalibration = true
    
    // MARK: - Properties
    var lmanager : CLLocationManager = CLLocationManager()
    public var currentLocation : CLLocation?
    var askForAuthorizationIfNeeded = false
    public var heading: Double?
    public weak var delegate: QiblaDirectionDelegate?
    
    public var angleOfQibla: Double?{
        didSet{
            if angleOfQibla != oldValue{
                // Inform Delegate
                self.delegate?.qiblaAngleDidChanged(angleOfQibla!)
            }
        }
    }
    
    // MARK: - Class
    public init(delegate: QiblaDirectionDelegate, askForAuthorizationIfNeeded: Bool = false){
        super.init()
        
        lmanager.activityType = CLActivityType.Other
        lmanager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
        lmanager.distanceFilter = 1000.0
        lmanager.delegate = self;
        
        self.delegate = delegate
        self.askForAuthorizationIfNeeded = askForAuthorizationIfNeeded
    }
    
    deinit{
        self.delegate = nil
        lmanager.stopUpdatingLocation()
        lmanager.stopUpdatingHeading()
    }
    
    // MARK: - Public functions
    public func tryStartUpdating()
    {
        if isLocationServiceAuthorized(){
            lmanager.startUpdatingLocation()
            lmanager.startUpdatingHeading()
            self.currentLocation = lmanager.location
        }
        else {
            self.delegate?.qiblaDirectionNeedsAuthorization()
            if self.askForAuthorizationIfNeeded {
                lmanager.requestWhenInUseAuthorization()
            }
        }
    }
    
    // MARK: - Private functions
    func isLocationServiceAuthorized() -> Bool{
        
        if CLLocationManager.locationServicesEnabled() == false {
            return false // globally disabled.
        }
        
        var status : Bool
        switch CLLocationManager.authorizationStatus() {
            
        case .AuthorizedAlways, .AuthorizedWhenInUse:
            status = true
            break;
            
        case .Denied, .Restricted, .NotDetermined:
            status = false
            break;
        }
        
        return status
    }
    
    func angleOfQiblaClockwiseFromTrueNorth(lat: Double, lon: Double) -> Double?{
        let a = abs(lat - self.lattituteOfMecca)
        let b = abs(0.0-0.01)
        let c = abs(lon - self.longtitueOfMecca)
        let d = abs(0.0-0.01)
        
        if a < b && c < d {
            // Already in Mecca
            self.delegate?.qiblaHeadingDidChange(true, headingAngle: 0.0)
            return nil
        }
        
        let phiK = self.lattituteOfMecca * M_PI / 180.0
        let lambdaK = self.longtitueOfMecca * M_PI / 180.0
        let phi = lat * M_PI / 180.0
        let lambda = lon * M_PI / 180.0
        
        let psi = round(180.0 / M_PI * atan2( sin(lambdaK-lambda), cos(phi) * tan(phiK) - sin(phi) * cos(lambdaK-lambda)))
        
        let degree : Double
        
        if psi < 0{
            degree = 360.0 - abs(psi)
        }
        else {
            degree = psi
        }
        
        return degree
    }
    
    // MARK: - CLLocationManagerDelegate
    public func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.delegate?.locationManager(manager, didUpdateLocations: locations)
        
        if let currentLocation: CLLocation = locations.last {
            self.currentLocation = currentLocation
        }
    }
    
    public func locationManager(manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        self.delegate?.locationManager(manager, didUpdateHeading: newHeading)
        
        if let coordinate = self.currentLocation?.coordinate {
            let currentAngle = Double(newHeading.magneticHeading)
            if let angleOfQibla = angleOfQiblaClockwiseFromTrueNorth(coordinate.latitude, lon: coordinate.longitude)
            {
                self.angleOfQibla = angleOfQibla
                
                // In Point
                let result = currentAngle - angleOfQibla
                var inPoint = false
                if result < self.accurency && result > (-1.0 * self.accurency) {
                    inPoint = true
                }
                
                // Inform delegate
                self.heading = currentAngle
                self.delegate?.qiblaHeadingDidChange(inPoint, headingAngle: currentAngle)
            }
        }
    }
    
    public func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        self.tryStartUpdating()
    }
    
    public func locationManagerShouldDisplayHeadingCalibration(manager: CLLocationManager) -> Bool {
        return self.shouldDisplayHeadingCalibration
    }
}
