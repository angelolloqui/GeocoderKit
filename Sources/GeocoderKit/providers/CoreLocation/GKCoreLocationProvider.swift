//
//  GKCoreLocationProvider.swift
//  GeocoderKit
//
//  Created by Angel Luis Garcia on 08/08/2019.
//  Copyright © 2019 angelolloqui. All rights reserved.
//

import Foundation
import CoreLocation

public extension GKGeocoderProvider {
    typealias CoreLocation = GKGeocoderProviderCoreLocation
}

public class GKGeocoderProviderCoreLocation: GKGeocoderProvider {
    private let geocoder: CLGeocoder

    public init(geocoder: CLGeocoder = CLGeocoder()) {
        self.geocoder = geocoder
    }

    public func reverseGeocodeLocation(_ location: CLLocation, preferredLocale locale: Locale?, completionHandler: @escaping GKGeocodeCompletionHandler) {
        if #available(iOS 11.0, *) {
            geocoder.reverseGeocodeLocation(location, preferredLocale: locale) { places, error in
                completionHandler(places?.compactMap { try? CoreLocationPlacemark(placemark: $0) }, error)
            }
        } else {
            geocoder.reverseGeocodeLocation(location) { places, error in
                completionHandler(places?.compactMap { try? CoreLocationPlacemark(placemark: $0) }, error)
            }
        }
    }

}

