![status](https://travis-ci.org/angelolloqui/GeocoderKit.svg?branch=develop)
![Swift 5.0](https://img.shields.io/badge/swift-5.0-brightgreen.svg)
![Swift Package Manager](https://img.shields.io/badge/SPM-ready-brightgreen.svg)
[![License](https://img.shields.io/badge/license-MIT-lightgrey.svg?maxAge=2592000)](https://opensource.org/licenses/MIT)
[![Twitter](https://img.shields.io/badge/twitter-@angelolloqui-blue.svg?maxAge=2592000)](http://twitter.com/angelolloqui)

# GeocoderKit

A drop-in replace for Apple's CLGeocoder class to allow multiple providers and provide failure handling with backup services

## Why?
Apple's geocoder is used extensibly in iOS development. However, when it comes to results, it is not always the most accurate or user friendly geocoder available. On the other hand, there are a plethora of thrid party providers for geocoding services, each offering their own API and model definitions, that despite being similar, are not equal. 

This library aims for providing a unique interface for any existing service keeping Apple's Core Location API and model to allow quick integration into existing applications. Besides, it offers a fail over mechanism that allows for returning results even when the default provider fails: it will always try to resolve the geocoding request with the array of providers given (in sequential order), until one succeeds.


## Supported services
Currently, GeocoderKit supports the following geocoding services:

- CoreLocation 
- Google
- Here

If you want to support another provider, please feel free to make a PR that inclues a `GKGeocoderProvider`  class with the implementation, together with some tests.

Note that the current version does only support reverse geocoding, but it will include the rest of the methods in future versions.

## Requirements
- iOS 10.0+
- Swift 5.0+

## Installation
GeocoderKit supports multiple methods for installing the library in a project.

### Installation with CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for Objective-C, which automates and simplifies the process of using 3rd-party libraries like GeocoderKit in your projects. You can install it with the following command:

```bash
$ gem install cocoapods
```

#### Podfile

To integrate GeocoderKit into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
pod 'GeocoderKit', '~> 0.0.1'
```

Then, run the following command:

```bash
$ pod install
```
### Installation with Swift Package Manager (SPM)

[The Swift Package Manager ](https://swift.org/package-manager/) is a tool for managing the distribution of Swift code. It’s integrated with the Swift build system to automate the process of downloading, compiling, and linking dependencies. You can install it adding the dependency to your `Packaget.swift` file:

```swift
dependencies: [
    .package(url: "https://github.com/angelolloqui/GeocoderKit.git", from: "0.0.1")
]
```


## Usage

Wherever you are using the `CLGeocoder` class, just add:

```ìmport GeocoderKit```

and replace any `CLGeocoder` reference by a `GKGeocoder`  instance.

You can create an `GKGeocoder` instance like the following:

```
GKGeocoder(providers: [
   GKGeocoderProvider.Here(appId: appId, appCode: appCode),
   GKGeocoderProvider.CoreLocation()
])
```
The previous code will configure the geocoder to first try Here.com and, if it fails, fall back into Apple's Core Location.  

And use it normally:

```
geocoder.reverseGeocodeLocation(location) { (placemark, error) in
// My handler
}
```

## License
GeocoderKit is released under the MIT license. See LICENSE for details.
