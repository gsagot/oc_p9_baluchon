//
//  URLProtocolFake.swift
//  iOS_testTests
//
//  Created by Gilles Sagot on 06/07/2021.
//

import Foundation

final class FakeURLWithProtocol: URLProtocol {
    
    static var request: ((URLRequest) -> ( Data?, HTTPURLResponse?, Error?))?
    
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }

    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }

    override func startLoading() {
        guard let result = FakeURLWithProtocol.request else {
            return
        }
        let (data, response, error) = result(request)

        if let responseStrong = response {
            client?.urlProtocol(self, didReceive: responseStrong, cacheStoragePolicy: .notAllowed)
        }
        if let dataStrong = data {
            client?.urlProtocol(self, didLoad: dataStrong)
        }
        if let errorStrong = error {
            client?.urlProtocol(self, didFailWithError: errorStrong)
        }
        client?.urlProtocolDidFinishLoading(self)
  
    }
    
    override func stopLoading() {
    }

}


