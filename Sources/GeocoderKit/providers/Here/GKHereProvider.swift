//
//  GKHereProvider.swift
//  GeocoderKit
//
//  Created by Angel Luis Garcia on 11/08/2019.
//  Copyright © 2019 angelolloqui. All rights reserved.
//

import Foundation
import CoreLocation

public extension GKGeocoderProvider {
    typealias Here = GKGeocoderProviderHere
}

public class GKGeocoderProviderHere: GKGeocoderProvider {
    let urlSession: URLSession
    let appId: String
    let appCode: String

    public init(appId: String, appCode: String, urlSession: URLSession = URLSession.shared) {
        self.appId = appId
        self.appCode = appCode
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
            let results = ((json["Response"] as? [String: Any])?["View"] as? [[String: Any]])?.first?["Result"] as? [[String: Any]]
            let placemarks = results?.compactMap { try? HerePlacemark(json: $0) }
            completionHandler(placemarks, placemarks == nil ? GKErrors.invalidResponse(data: data) : nil)
            }.resume()
    }

    private func reverseGeocodingUrl(location: CLLocation, locale: Locale) -> URL? {
        return URL(string: "https://reverse.geocoder.api.here.com/6.2/reversegeocode.json" +
            "?app_id=\(appId)&app_code=\(appCode)&mode=retrieveAddresses" +
            "&prox=\(location.coordinate.latitude),\(location.coordinate.longitude)&language=\(locale.identifier)" +
            "&locationattributes=adminInfo,timeZone&additionaldata=Country2,true")
    }
}
