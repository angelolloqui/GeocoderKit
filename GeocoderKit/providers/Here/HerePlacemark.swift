//
//  HerePlacemark.swift
//  GeocoderKit
//
//  Created by Angel Luis Garcia on 11/08/2019.
//  Copyright © 2019 angelolloqui. All rights reserved.
//

import Foundation
import CoreLocation

class HerePlacemark: GKPlacemark {
    convenience init(json: [String: Any]) throws {
        guard let locationJson = json["Location"] as? [String: Any],
            let positionJson = locationJson["DisplayPosition"] as? [String: Any],
            let lat = positionJson["Latitude"] as? Double,
            let lon = positionJson["Longitude"] as? Double else {
            throw GKErrors.invalidData
        }
        self.init()
        location = CLLocation(latitude: lat, longitude: lon)

        if let addressJson = locationJson["Address"] as? [String: Any] {
            administrativeArea = addressJson["State"] as? String
            subAdministrativeArea = addressJson["County"] as? String
            locality = addressJson["City"] as? String
            subLocality = addressJson["District"] as? String
            thoroughfare = addressJson["Street"] as? String
            subThoroughfare = addressJson["HouseNumber"] as? String
            postalCode = addressJson["PostalCode"] as? String
            (addressJson["AdditionalData"] as? [[String: String]])?.forEach { additionalJson in
                let key = additionalJson["key"]
                let value = additionalJson["value"]
                if key == "Country2" {
                    isoCountryCode = value
                } else if key == "CountryName" {
                    country = value
                }
            }
        }
        if let adminJson = locationJson["AdminInfo"] as? [String: Any], let timeZoneJson = adminJson["TimeZoneOffset"] as? String {
            timeZone = TimeZone(abbreviation: timeZoneJson)
        }
    }
}
