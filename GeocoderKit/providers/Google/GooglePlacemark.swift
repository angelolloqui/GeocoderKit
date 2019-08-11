//
//  GooglePlacemark.swift
//  GeocoderKit
//
//  Created by Angel Luis Garcia on 08/08/2019.
//  Copyright © 2019 angelolloqui. All rights reserved.
//

import Foundation
import CoreLocation

class GooglePlacemark: GKPlacemark {
    convenience init(json: [String: Any]) throws {
        guard let geometryJson = json["geometry"] as? [String: Any],
            let locationJson = geometryJson["location"] as? [String: Any],
            let lat = locationJson["lat"] as? Double,
            let lon = locationJson["lng"] as? Double,
            let addressComponents = json["address_components"] as? [[String: Any]] else {
                throw GKErrors.invalidData
        }
        self.init()
        location = CLLocation(latitude: lat, longitude: lon)
        name = json["name"] as? String

        for component in addressComponents {
            guard let types = component["types"] as? [String] else { continue }
            let longName = component["long_name"] as? String
            let shortName = component["short_name"] as? String

            if types.contains("street_number") {
                subThoroughfare = longName
            } else if types.contains("route") {
                thoroughfare = longName
            } else if types.contains("locality") {
                locality = longName
            } else if types.contains("sublocality") {
                subLocality = longName
            } else if types.contains("administrative_area_level_1") {
                administrativeArea = longName
            } else if types.contains("administrative_area_level_2") {
                subAdministrativeArea = longName
            } else if types.contains("postal_code") {
                postalCode = longName
            } else if types.contains("country") {
                country = longName
                isoCountryCode = shortName
            }
        }
    }
}
