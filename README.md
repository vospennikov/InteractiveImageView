## InteractiveImageView
![Swift](https://img.shields.io/badge/Swift-5.8-orange?style=flat)
![Platform](https://img.shields.io/badge/Platform-iOS%2013-orange)
![Framework](https://img.shields.io/badge/Framework-UIKit%20%7C%20SwiftUI-orange)
![Swift Package Manager](https://img.shields.io/badge/Swift_Package_Manager-compatible-orange?style=flat)
![GitHub](https://img.shields.io/badge/Licence-MIT-orange)

InteractiveImageView is an open-source library that provides experience showing images like a Photos App on iPhone. (Tap to zoom, pinch and pan gestures, rotation with keep position, motion inertia). The view supports UIKit and SwiftUI framework. 

![Demo](Images/demo.gif)

## Usage
### SwiftUI
```swift
@State var tapLocation: CGPoint = .zero
InteractiveImage(image: .init(named: "Iceland"), handleZoomingTap: $tapLocation)
```
SwiftUI before iOS 16 didn't support touch location detection. To zoom to the touch location, you could use the [Gestures](https://github.com/vospennikov/Gestures) package.
```swift
.onTouchGesture(count: 2) { gesture in
  tapLocation = gesture.location
}
```
### UIKit
```swift
var interactiveImageView = InteractiveImageView(maxScale: 2.0)
interactiveImageView.image = UIImage(named: "Iceland")

func gestureHandler(_ sender: UITapGestureRecognizer) {
  let location = sender.location(in: imageView)
  interactiveImageView.zoom(to: location, animated: true)
}
```

## Installation
### Swift Package Manager
Add the following dependency to your **Package.swift** file:
```swift
.package(url: "https://github.com/vospennikov/InteractiveImageView.git", .upToNextMinor(from: "1.0.6"))
```

## License
Gestures is available under the MIT license. See the LICENSE file for more info.
