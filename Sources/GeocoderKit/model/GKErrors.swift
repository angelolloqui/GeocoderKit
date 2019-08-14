//
//  GKErrors.swift
//  GeocoderKit
//
//  Created by Angel Luis Garcia on 08/08/2019.
//  Copyright © 2019 angelolloqui. All rights reserved.
//

import Foundation

public enum GKErrors: Error {
    case noGeocoders
    case invalidData
    case invalidResponse(data: Data?)
}
