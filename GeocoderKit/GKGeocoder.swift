//
//  GKGeocoder.swift
//  GeocoderKit
//
//  Created by Angel Luis Garcia on 08/08/2019.
//  Copyright © 2019 angelolloqui. All rights reserved.
//

import Foundation
import CoreLocation

public typealias GKGeocodeCompletionHandler = ([GKPlacemark]?, Error?) -> Void

public class GKGeocoder {
    private let providers: [GKGeocoderProvider]

    public init(providers: [GKGeocoderProvider]) {
        self.providers = providers
    }
}

// MARK: - Public API
public extension GKGeocoder {

    func reverseGeocodeLocation(_ location: CLLocation, preferredLocale locale: Locale?, completionHandler: @escaping GKGeocodeCompletionHandler) {
        reverseGeocodeLocation(providers: providers, location: location, locale: locale, completionHandler: completionHandler)
    }

    func reverseGeocodeLocation(_ location: CLLocation, completionHandler: @escaping GKGeocodeCompletionHandler) {
        reverseGeocodeLocation(providers: providers, location: location, locale: nil, completionHandler: completionHandler)
    }
}

// MARK: - Private methods
private extension GKGeocoder {
    func reverseGeocodeLocation(providers: [GKGeocoderProvider], location: CLLocation, locale: Locale?, completionHandler: @escaping GKGeocodeCompletionHandler) {
        guard let provider = providers.first else {
            completionHandler(nil, GKErrors.noGeocoders)
            return
        }
        provider.reverseGeocodeLocation(location, preferredLocale: locale) { (placemarks, error) in
            if let error = error {
                let otherProviders = Array(providers.dropFirst())
                if otherProviders.isEmpty {
                    completionHandler(nil, error)
                } else {
                    self.reverseGeocodeLocation(providers: otherProviders, location: location, locale: locale, completionHandler: completionHandler)
                }
            } else if let placemarks = placemarks {
                completionHandler(placemarks, nil)
            }
        }
    }
}
