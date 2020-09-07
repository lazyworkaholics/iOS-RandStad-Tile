//
//  NetworkManagerTests.swift
//  RandStadPOC
//
//  Created by Harsha VARDHAN on 05/09/2020.
//  Copyright © 2020 Harsha VARDHAN. All rights reserved.
//

import XCTest
import Reachability

@testable import RandStadPOC

class NetworkManagerTests: XCTestCase {
    
    var networkManagerToTest: NetworkManager?
    
    override func setUp() {
        networkManagerToTest = NetworkManager.sharedInstance as? NetworkManager
    }
    
    override func tearDown() {
        let defaultConfiguration = URLSessionConfiguration.default
        networkManagerToTest?.urlSession = URLSession.init(configuration: defaultConfiguration)
        networkManagerToTest?.reachability = Reachability.forInternetConnection()
    }
    
    func testInternalServerError() {
        let mockSession = URLSessionMock()
        mockSession.data = nil
        mockSession.response = HTTPURLResponse.init(url: URL.init(string:"https://www.google.com")! ,
                                                    statusCode: 500,
                                                    httpVersion: nil,
                                                    headerFields: nil)
        mockSession.error = nil
        
        let mockReachability = ReachabilityMock.forInternetConnection() as! ReachabilityMock
        mockReachability.reachableViaWifi = true
        mockReachability.reachableViaWWAN = true
        
        networkManagerToTest?.urlSession = mockSession
        networkManagerToTest?.reachability = mockReachability
        
        networkManagerToTest?.httpRequest("test",
                                          params: nil,
                                          method: HTTPRequestType.GET,
                                          headers: nil,
                                          body: nil,
                                          onSuccess: {
                                            (responseData) in
                                            XCTFail("Success block should not be called if there is an internal server error.")
        },
                                          onFailure: {
                                            (error) in
                                            XCTAssertEqual(500, error.code, "Error object should return error code 500")
        })
    }
    
    func testNoInternetConnection() {
        let mockReachability = ReachabilityMock.forInternetConnection() as! ReachabilityMock
        mockReachability.reachableViaWifi = false
        mockReachability.reachableViaWWAN = false
        
        networkManagerToTest?.reachability = mockReachability
        
        networkManagerToTest?.httpRequest("test",
                                          params: nil,
                                          method: HTTPRequestType.GET,
                                          headers: nil,
                                          body: nil,
                                          onSuccess: { (
                                            responseData) in
                                            XCTFail("Success block should not be called if there is no network connection.")
        },
                                          onFailure: {
                                            (error) in
                                            XCTAssertEqual(Network_Error_Constants.NOT_REACHABLE, error.code, "Error object should return error code 1")
        })
    }
    
    func testSuccessCase() {
        let mockSession = URLSessionMock()
        let mockRequestData = Data.init(base64Encoded:"tahfahfhfaisfhaihf")
        let mockResponseData = Data.init(base64Encoded:"VGhpcyBpcyBub3QgYSBKU09O")
        mockSession.data = mockResponseData
        mockSession.response = HTTPURLResponse.init(url: URL.init(string:"https://www.google.com")! ,
                                                    statusCode: 200,
                                                    httpVersion: nil,
                                                    headerFields: nil)
        mockSession.error = nil
        
        let mockReachability = ReachabilityMock.forInternetConnection() as! ReachabilityMock
        mockReachability.reachableViaWifi = true
        mockReachability.reachableViaWWAN = true
        
        networkManagerToTest?.urlSession = mockSession
        networkManagerToTest?.reachability = mockReachability
        
        networkManagerToTest?.httpRequest("test",
                                          params: ["biw":"1881", "bih":"1066"],
                                          method: HTTPRequestType.GET,
                                          headers: nil,
                                          body: mockRequestData,
                                          onSuccess: {
                                            (responseData) in
                                            XCTAssertEqual(responseData, mockResponseData, "response data is mismatched")
        },
                                          onFailure: { (error) in
                                            XCTFail("Success block should not be called if JSON data is corrupt")
                                            
        })
    }
    
    func test_nilOtherParams() {
        let mockSession = URLSessionMock()
        let mockResponseData = Data.init(base64Encoded:"VGhpcyBpcyBub3QgYSBKU09O")
        mockSession.data = mockResponseData
        mockSession.response = HTTPURLResponse.init(url: URL.init(string:"https://www.google.com")! ,
                                                    statusCode: 200,
                                                    httpVersion: nil,
                                                    headerFields: nil)
        mockSession.error = nil
        
        let mockReachability = ReachabilityMock.forInternetConnection() as! ReachabilityMock
        mockReachability.reachableViaWifi = true
        mockReachability.reachableViaWWAN = true
        
        networkManagerToTest?.urlSession = mockSession
        networkManagerToTest?.reachability = mockReachability
        
        networkManagerToTest?.httpRequest("test",
                                          params: [:],
                                          method: HTTPRequestType.GET,
                                          headers: ["header1":"test1","header2":"test2"],
                                          body: Data(),
                                          onSuccess: {
                                            (responseData) in
                                            XCTAssertEqual(responseData, mockResponseData, "response data is mismatched")
        },
                                          onFailure: { (error) in
                                            XCTFail("Success block should not be called if JSON data is corrupt")
                                            
        })
    }
}
