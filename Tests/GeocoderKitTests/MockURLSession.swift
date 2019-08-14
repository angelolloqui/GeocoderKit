//
//  MockURLSession.swift
//  GeocoderKitTests
//
//  Created by Angel Luis Garcia on 11/08/2019.
//  Copyright © 2019 angelolloqui. All rights reserved.
//

import Foundation

class MockURLSession: URLSession {
    private (set) var lastURL: URL?
    private var mockData: Data?

    func mockWith(jsonFile: String) {
        mockData = dataFrom(jsonFile: jsonFile)
    }

    func mockWith(data: Data) {
        mockData = data
    }

    override func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        lastURL = url
        return MockURLSessionDataTask(url: url, mockData: mockData, completionHandler: completionHandler)
    }

    private func dataFrom(jsonFile: String, testPath: String = #file) -> Data? {
        let path = URL(fileURLWithPath: testPath)
            .deletingLastPathComponent()
            .deletingLastPathComponent()
            .appendingPathComponent("assets", isDirectory: true)
            .appendingPathComponent("\(jsonFile).json")
            .path
        return try? Data(contentsOf: URL(fileURLWithPath: path))
    }
}

class MockURLSessionDataTask: URLSessionDataTask {
    private let url: URL
    private let mockData: Data?
    private let completionHandler: (Data?, URLResponse?, Error?) -> Void

    init(url: URL, mockData: Data?, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        self.url = url
        self.mockData = mockData
        self.completionHandler = completionHandler
    }

    override func resume() {
        let response = URLResponse(url: url, mimeType: nil, expectedContentLength: 0, textEncodingName: nil)
        completionHandler(mockData, response, mockData == nil ? NSError(domain: "error", code: 0, userInfo: [:]) : nil)
    }
}
