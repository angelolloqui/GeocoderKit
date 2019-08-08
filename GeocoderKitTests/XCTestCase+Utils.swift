//
//  XCTestCase+Utils.swift
//  GeocoderKitTests
//
//  Created by Angel Luis Garcia on 08/08/2019.
//  Copyright © 2019 angelolloqui. All rights reserved.
//

import Foundation
import XCTest
import CoreLocation

extension XCTestCase {
    func waitForResult(timeout: TimeInterval = 5.0, _ call: ((@escaping CLGeocodeCompletionHandler) -> Void)) -> Result<[CLPlacemark], Error> {
        let expectation = self.expectation(description: self.name)
        var result: Result<[CLPlacemark], Error>?
        call { placemarks, error in
            if let placemarks = placemarks {
                result = Result.success(placemarks)
            } else {
                result = Result.failure(error ?? NSError(domain: "Unexpected result", code: 0, userInfo: [:]))
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: timeout)
        return result ?? Result.failure(NSError(domain: "Timeout", code: 1, userInfo: [:]))
    }
}
