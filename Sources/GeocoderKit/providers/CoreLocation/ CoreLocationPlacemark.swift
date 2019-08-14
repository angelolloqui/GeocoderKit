//
//   CoreLocationPlacemark.swift
//  GeocoderKit
//
//  Created by Angel Luis Garcia on 09/08/2019.
//  Copyright © 2019 angelolloqui. All rights reserved.
//

import Foundation
import CoreLocation

class CoreLocationPlacemark: GKPlacemark {
    convenience init(placemark: CLPlacemark) throws {
        guard let location = placemark.location else {
            throw GKErrors.invalidData
        }
        self.init()
        self.location = location
        self.region = placemark.region
        self.timeZone = placemark.timeZone
        self.name = placemark.name
        self.thoroughfare = placemark.thoroughfare
        self.subThoroughfare = placemark.subThoroughfare
        self.locality = placemark.locality
        self.subLocality = placemark.subLocality
        self.administrativeArea = placemark.administrativeArea
        self.subAdministrativeArea = placemark.subAdministrativeArea
        self.postalCode = placemark.postalCode
        self.isoCountryCode = placemark.isoCountryCode
        self.country = placemark.country
        self.inlandWater = placemark.inlandWater
        self.ocean = placemark.ocean
        self.areasOfInterest = placemark.areasOfInterest
    }
}
