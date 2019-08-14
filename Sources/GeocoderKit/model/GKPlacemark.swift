//
//  GKPlacemark.swift
//  GeocoderKit
//
//  Created by Angel Luis Garcia on 09/08/2019.
//  Copyright © 2019 angelolloqui. All rights reserved.
//

import Foundation
import CoreLocation

// CLPlacemark can not be subclassed (it crashes on deallocation) so we use this replacement class that has
// the same signature than the official CLPlacemark to allow drop in replacement
open class GKPlacemark: Equatable {
    var location: CLLocation?
    var region: CLRegion?
    var timeZone: TimeZone?
    var name: String?
    var thoroughfare: String?
    var subThoroughfare: String?
    var locality: String?
    var subLocality: String?
    var administrativeArea: String?
    var subAdministrativeArea: String?
    var postalCode: String?
    var isoCountryCode: String?
    var country: String?
    var inlandWater: String?
    var ocean: String?
    var areasOfInterest: [String]?

    public static func == (lhs: GKPlacemark, rhs: GKPlacemark) -> Bool {
        return lhs.location == rhs.location &&
            lhs.region == rhs.region &&
            lhs.timeZone == rhs.timeZone &&
            lhs.name == rhs.name &&
            lhs.thoroughfare == rhs.thoroughfare &&
            lhs.subThoroughfare == rhs.subThoroughfare &&
            lhs.locality == rhs.locality &&
            lhs.subLocality == rhs.subLocality &&
            lhs.administrativeArea == rhs.administrativeArea &&
            lhs.subAdministrativeArea == rhs.subAdministrativeArea &&
            lhs.postalCode == rhs.postalCode &&
            lhs.isoCountryCode == rhs.isoCountryCode &&
            lhs.country == rhs.country &&
            lhs.inlandWater == rhs.inlandWater &&
            lhs.ocean == rhs.ocean &&
            lhs.areasOfInterest == rhs.areasOfInterest
    }

}
