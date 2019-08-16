# GeocoderKit

A drop-in replace for Apple's CLGeocoder class to allow multiple providers and provide failure handling with backup services

## Why?
Apple's geocoder is used extensibly in iOS development. However, when it comes to results, it is not always the most accurate or user friendly geocoder available. On the other hand, there are a pletora of thrid party providers for geocoding services, each offering their own API and model definitions, that despite being similar, are not equal. 

This library aims for providing a unique interface for any existing service keeping Apple's Core Location model to allow quick integration into existing applications, and at the same time, it offers a fail over mechanism that allows for provider issues: it will always try to resolve the geocoding request with the array of providers given (in sequential order), until one succeeds.


## Supported services
Currently, GeocoderKit supports the following geocoding services:

- CoreLocation 
- Google
- Here

If you want to support another provider, please feel free to make a PR that inclues a `GKGeocoderProvider`  class with the implementation, together with some tests.

Note that the current version does only support reverse geocoding, but it will include the rest of the methods in future versions.

## Installation
WIP

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
