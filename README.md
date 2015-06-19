# QiblaDirection
Detects user's angle to Kaaba. 

## Installation

**QiblaDirection** can be added to your project using **Cocoapods**.  

```
use_frameworks!
pod 'QiblaDirection'
```

or just add the **QiblaDirection.swift** file to your project

## Usage

In your `ViewController`, add the following protocol: `QiblaDirectionDelegate`

Define **QiblaDirection** as an instance variable. 

You can handle *Location Authorization* yourself or also let the **QiblaDirection** handle itself by sending true to the **askForAuthorizationIfNeeded** parameter in the constructor method. 

```swift
var qibla: QiblaDirection?

override func viewDidLoad() {
		super.viewDidLoad()
		
		self.qibla = QiblaDirection(delegate: self, askForAuthorizationIfNeeded: true)
		self.qibla?.tryStartUpdating()
	}
```

*Note: In your Info.plist file, be sure the following key exists with a brief description to ensure location services is enabled for your app: `NSLocationWhenInUseUsageDescription`*

### Handling Delegate Methods

```swift
	func qiblaDirectionNeedsAuthorization() {
		// Authorisation can be handled here.
	}

	func qiblaHeadingDidChange(inPoint: Bool, headingAngle: Double) {
		let text = inPoint ? "YES" : "NO"
		println("Qibla in point: \(text) \nHeading angle  \(headingAngle) degree")
	}

	func qiblaAngleDidChanged(angle: Double) {
		println("Qibla Angle: \(angle) degree")
	}
```



