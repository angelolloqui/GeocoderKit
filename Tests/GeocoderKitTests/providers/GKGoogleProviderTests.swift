//
//  GKGoogleProviderTests.swift
//  GeocoderKitTests
//
//  Created by Angel Luis Garcia on 08/08/2019.
//  Copyright © 2019 angelolloqui. All rights reserved.
//

import XCTest
import CoreLocation
@testable import GeocoderKit

class GKGoogleProviderTests: XCTestCase {
    let location = CLLocation(latitude: 40.450942, longitude:-3.691530)
    var provider: GKGeocoderProvider.Google!
    var mockURLSession: MockURLSession!

    override func setUp() {
        self.mockURLSession = MockURLSession()
        self.provider = GKGeocoderProvider.Google(apiKey: "notARealSecret",
                                                  urlSession: mockURLSession)
    }

    func testWhenReverseGeocodingThenResultsSuccess() {
        mockURLSession.mockWith(jsonFile: "google")

        let result = waitForResult { provider.reverseGeocodeLocation(location, preferredLocale: Locale(identifier: "es"), completionHandler: $0) }
        let placemark = try? result.get().first
        XCTAssertNotNil(mockURLSession.lastURL)
        XCTAssertNotNil(placemark)
        XCTAssertNil(placemark?.name)
        XCTAssertEqual(placemark?.isoCountryCode, "ES")
        XCTAssertEqual(placemark?.country, "España")
        XCTAssertEqual(placemark?.postalCode, "28046")
        XCTAssertEqual(placemark?.administrativeArea, "Comunidad de Madrid")
        XCTAssertEqual(placemark?.subAdministrativeArea, "Madrid")
        XCTAssertEqual(placemark?.locality, "Madrid")
        XCTAssertEqual(placemark?.subLocality, "Cuatro Caminos")
        XCTAssertEqual(placemark?.thoroughfare, "Paseo de la Castellana")
        XCTAssertEqual(placemark?.subThoroughfare, "93")
        XCTAssertNil(placemark?.region)
        XCTAssertNil(placemark?.timeZone)
    }

}
