# GeocoderKit

A drop-in replace for Apple's CLGeocoder class to allow multiple providers and provide failure handling with other services

## Why?
Apple's geocoder is used extensibly in iOS development. However, when it comes to results, it is not always the most accurate or user friendly geocoder available. On the other hand, there are a pletora of thrid party providers for geocoding services, each offering their own API and model definitions, that despite being similar, are not equal. 

This library aims for providing a unique interface for any existing service, and at the same time, it offers a fail over mechanism that allows for provider issues: it will always try, in sequential order, to resolve the geocoding request with the array of providers given, until one succeeds.


## Supported services
Currently, GeocoderKit supports the following geocoding services:

- CoreLocation 
- Google
- Here

If you want to support another provider, please feel free to make a PR that inclues a `GKGeocoderProvider`  class with the implementation, together with some tests.


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

