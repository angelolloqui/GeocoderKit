//
//  GKGoogleProvider.swift
//  GeocoderKit
//
//  Created by Angel Luis Garcia on 08/08/2019.
//  Copyright © 2019 angelolloqui. All rights reserved.
//

import Foundation
import CoreLocation

public extension GKGeocoderProvider {
    typealias Google = GKGeocoderProviderGoogle
}

public class GKGeocoderProviderGoogle: GKGeocoderProvider {
    let urlSession: URLSession
    let apiKey: String

    public init(apiKey: String, urlSession: URLSession = URLSession.shared) {
        self.apiKey = apiKey
        self.urlSession = urlSession
    }

    public func reverseGeocodeLocation(_ location: CLLocation, preferredLocale locale: Locale?, completionHandler: @escaping GKGeocodeCompletionHandler) {
        guard let url = reverseGeocodingUrl(location: location, locale: locale ?? Locale.current) else {
            completionHandler(nil, GKErrors.invalidData)
            return
        }
        urlSession.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completionHandler(nil, error)
                return
            }
            guard data != nil, let json = try? JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any] else {
                completionHandler(nil, GKErrors.invalidResponse(data: data))
                return
            }
            let placemarks = (json["results"] as? [[String: Any]])?.compactMap { try? GooglePlacemark(json: $0) }
            completionHandler(placemarks, placemarks == nil ? GKErrors.invalidResponse(data: data) : nil)
        }.resume()
    }

    private func reverseGeocodingUrl(location: CLLocation, locale: Locale) -> URL? {
        return URL(string: "https://maps.googleapis.com/maps/api/geocode/json?key=\(apiKey)" +
            "&latlng=\(location.coordinate.latitude),\(location.coordinate.longitude)" +
            "&language=\(locale.identifier)&sensor=true")
    }
}
