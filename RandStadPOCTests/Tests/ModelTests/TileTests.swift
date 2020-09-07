//
//  TileTests.swift
//  RandStadPOCTests
//
//  Created by Harsha VARDHAN on 05/09/2020.
//  Copyright © 2020 Harsha VARDHAN. All rights reserved.
//

import XCTest
@testable import RandStadPOC

class TileTests: XCTestCase {
    
    var tile:Tile?
    var tileMessage:TileMessage?
    var serviceError:NSError?
    var mockServiceManager:ServiceManagerMock?

    override func setUp() {
        
        tile = Tile.init("test_id", label: "test_label", priority: 0.25)
        tileMessage = TileMessage.init("test_message")
        serviceError = NSError.init(domain: "testDomain", code: 1000, userInfo: nil)
        mockServiceManager = ServiceManagerMock()
    }
    
    override func tearDown() {
        
        tile = nil
        tileMessage = nil
        serviceError = nil
        mockServiceManager = nil
    }
    
    func test_NotEqualElements_comparision() {
        
        let tile1 = Tile.init("test_id1", label: "test_label1", priority: 0.5)
        let tile2 = Tile.init("test_id2", label: "test_label2", priority: 0.75)
        
        if tile1 != tile2 {
            XCTAssert(true)
        }
        else {
            XCTFail()
        }
        
        if tile1 == tile2 {
            XCTFail()
        }
        else {
            XCTAssert(true)
        }
    }
    
    func test_equalElements_comparision() {
        
        let tile1 = Tile.init("test_id1", label: "test_label1", priority: 0.5)
        let tile2 = Tile.init("test_id1", label: "test_label1", priority: 0.5)
        
        if tile1 != tile2 {
            XCTFail()
        }
        else {
           XCTAssert(true)
        }
        
        if tile1 == tile2 {
            XCTAssert(true)
        }
        else {
            XCTFail()
        }
    }
    
    func test_getMessage_failure() {
        
        mockServiceManager?.getMessage_error = serviceError
        mockServiceManager?.is_getMessage_Success = false
        tile?.serviceManager = mockServiceManager!
        
        tile?.messageObserver = ({
            (tileMessage, error, serviceEvent) -> Void in
            
            XCTAssertEqual(tileMessage, nil, "tile message should be nil in failure case")
            XCTAssertEqual(error, self.serviceError, "error received different")
            XCTAssertEqual(serviceEvent, TileServiceEvent.MessageFetch)
            XCTAssertEqual(self.mockServiceManager?.is_getMessage_SuccessBlock_invoked, false)
            XCTAssertEqual(self.mockServiceManager?.is_getMessage_FailureBlock_invoked, true)
        })
        tile?.fetchMessage()
    }
    
    func test_getMessage_Success() {
        
        mockServiceManager?.tileMessage = tileMessage
        mockServiceManager?.is_getMessage_Success = true
        tile?.serviceManager = mockServiceManager!
        
        tile?.messageObserver = ({
            (tileMessage, error, serviceEvent) -> Void in
            
            XCTAssertEqual(tileMessage, self.tileMessage!.message, "tile message received different")
            XCTAssertEqual(error, nil, "error should be nil in success case")
            XCTAssertEqual(serviceEvent, TileServiceEvent.MessageFetch)
            XCTAssertEqual(self.mockServiceManager?.is_getMessage_SuccessBlock_invoked, true)
            XCTAssertEqual(self.mockServiceManager?.is_getMessage_FailureBlock_invoked, false)
        })
        tile?.fetchMessage()
    }
}
