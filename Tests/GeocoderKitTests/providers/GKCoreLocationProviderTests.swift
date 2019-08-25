//
//  GKCoreLocationProviderTests.swift
//  GeocoderKitTests
//
//  Created by Angel Luis Garcia on 08/08/2019.
//  Copyright © 2019 angelolloqui. All rights reserved.
//

import XCTest
import CoreLocation
@testable import GeocoderKit

class GKCoreLocationProviderTests: XCTestCase {
    let location = CLLocation(latitude: 40.450942, longitude:-3.691530)
    var provider: GKGeocoderProvider.CoreLocation!

    override func setUp() {
        self.provider = GKGeocoderProvider.CoreLocation()
    }

    func testWhenReverseGeocodingThenResultsSuccess() {
        let result = waitForResult { provider.reverseGeocodeLocation(location, preferredLocale: Locale(identifier: "es"), completionHandler: $0) }
        let placemark = try? result.get().first
        XCTAssertNotNil(placemark)
        XCTAssertNotNil(placemark?.name)
        XCTAssertEqual(placemark?.isoCountryCode, "ES")
        //XCTAssertEqual(placemark?.country, "España")
        XCTAssertEqual(placemark?.postalCode, "28046")
        XCTAssertEqual(placemark?.administrativeArea, "Madrid")
        XCTAssertEqual(placemark?.subAdministrativeArea, "Madrid")
        XCTAssertEqual(placemark?.locality, "Madrid")
        XCTAssertEqual(placemark?.subLocality, "Cuatro Caminos")
        XCTAssertEqual(placemark?.thoroughfare, "Paseo de la Castellana")
        XCTAssertEqual(placemark?.subThoroughfare, "93")
        XCTAssertNotNil(placemark?.region)
        XCTAssertEqual(placemark?.timeZone?.identifier, "Europe/Madrid")
    }

}

