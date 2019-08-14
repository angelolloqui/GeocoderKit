//
//  GKGeocoderProvider.swift
//  GeocoderKit
//
//  Created by Angel Luis Garcia on 08/08/2019.
//  Copyright © 2019 angelolloqui. All rights reserved.
//

import Foundation
import CoreLocation

public protocol GKGeocoderProvider {
    func reverseGeocodeLocation(_ location: CLLocation, preferredLocale locale: Locale?, completionHandler: @escaping GKGeocodeCompletionHandler)
}
