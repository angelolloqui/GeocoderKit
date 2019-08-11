//
//  GeocoderKitTests.swift
//  GeocoderKitTests
//
//  Created by Angel Luis Garcia on 08/08/2019.
//  Copyright © 2019 angelolloqui. All rights reserved.
//

import XCTest
import CoreLocation
@testable import GeocoderKit

class GeocoderKitTests: XCTestCase {
    private let location = CLLocation(latitude: 40.450942, longitude:-3.691530)
    private var geocoder: GKGeocoder!
    private var mockProviders: [MockProvider]!

    override func setUp() {
        self.mockProviders = [
            MockProvider(),
            MockProvider(),
            MockProvider()
        ]
        self.geocoder = GKGeocoder(providers: mockProviders)
    }

    func testWhenFirstSucceedsThenResultsOK() {
        let placemarks = [GKPlacemark()]
        mockProviders[0].mockResult = Result.success(placemarks)
        let result = waitForResult { geocoder.reverseGeocodeLocation(location, completionHandler: $0) }
        XCTAssertEqual(placemarks, try? result.get())
        XCTAssertTrue(mockProviders[0].reverseGecodeCalled)
        XCTAssertFalse(mockProviders[1].reverseGecodeCalled)
        XCTAssertFalse(mockProviders[2].reverseGecodeCalled)
    }

    func testWhenFirstFailsThenTriesNextResults() {
        let placemarks = [GKPlacemark()]
        mockProviders[0].mockResult = Result.failure(NSError(domain: "Error", code: 0, userInfo: [:]))
        mockProviders[1].mockResult = Result.success(placemarks)
        let result = waitForResult { geocoder.reverseGeocodeLocation(location, completionHandler: $0) }
        XCTAssertEqual(placemarks, try? result.get())
        XCTAssertTrue(mockProviders[0].reverseGecodeCalled)
        XCTAssertTrue(mockProviders[1].reverseGecodeCalled)
        XCTAssertFalse(mockProviders[2].reverseGecodeCalled)
    }

    func testWhenAllFailsThenResultsLastError() {
        mockProviders[0].mockResult = Result.failure(NSError(domain: "Error 0", code: 0, userInfo: [:]))
        mockProviders[1].mockResult = Result.failure(NSError(domain: "Error 1", code: 1, userInfo: [:]))
        mockProviders[2].mockResult = Result.failure(NSError(domain: "Error 2", code: 2, userInfo: [:]))
        let result = waitForResult { geocoder.reverseGeocodeLocation(location, completionHandler: $0) }
        do {
            _ = try result.get()
            XCTFail("Should not have result")
        } catch let error {
            XCTAssertEqual((error as NSError).code, 2)
        }
        XCTAssertTrue(mockProviders[0].reverseGecodeCalled)
        XCTAssertTrue(mockProviders[1].reverseGecodeCalled)
        XCTAssertTrue(mockProviders[2].reverseGecodeCalled)
    }

    private class MockProvider: GKGeocoderProvider {
        var reverseGecodeCalled = false
        var mockResult: Result<[GKPlacemark], Error>!
        func reverseGeocodeLocation(_ location: CLLocation, preferredLocale locale: Locale?, completionHandler: @escaping GKGeocodeCompletionHandler) {
            reverseGecodeCalled = true
            do {
                try completionHandler(mockResult.get(), nil)
            } catch let error {
                completionHandler(nil, error)
            }
        }
    }
}

