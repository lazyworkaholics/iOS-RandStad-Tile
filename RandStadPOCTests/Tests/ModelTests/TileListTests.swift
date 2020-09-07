//
//  TileListTests.swift
//  RandStadPOCTests
//
//  Created by Harsha VARDHAN on 05/09/2020.
//  Copyright © 2020 Harsha VARDHAN. All rights reserved.
//

import XCTest
@testable import RandStadPOC

class TileListTests: XCTestCase {
    
    var tiles:[Tile] = []
    var serviceError:NSError?
    var mockServiceManager:ServiceManagerMock?

    override func setUp() {

        tiles = [Tile.init("test_id", label: "test_label", priority: 0.5),
                 Tile.init("test_id2", label: "test_label2", priority: 0.75)]
        
        serviceError = NSError.init(domain: "testDomain", code: 1000, userInfo: nil)
        mockServiceManager = ServiceManagerMock()
    }

    override func tearDown() {

        tiles = []
        mockServiceManager = nil
        serviceError = nil
    }
    
    func testContactList_fetch_Success() {
        
        mockServiceManager!.tilesList = self.tiles
        mockServiceManager!.is_getList_Success = true
        
        let tilesList = TileList.init({ (tiles, tileServiceEvent) in
            
            XCTAssertEqual(tiles, self.tiles, "tiles received different")
            XCTAssertEqual(tileServiceEvent, TileServiceEvent.ListFetch)
        }, errorObserver: { (error, tileServiceEvent) in
            XCTFail()
        })
        
        tilesList.serviceManager = mockServiceManager!
        tilesList.fetch()
    }
    
    func testContactList_fetch_failure() {
        
        mockServiceManager!.getList_error = self.serviceError
        mockServiceManager!.is_getList_Success = false
        
        let tilesList = TileList.init({ (tiles, tileServiceEvent) in
            
            XCTFail()
        }, errorObserver: { (error, tileServiceEvent) in
            
            XCTAssertEqual(error, self.serviceError, "error received different")
            XCTAssertEqual(tileServiceEvent, TileServiceEvent.ListFetch)
        })
        
        tilesList.serviceManager = mockServiceManager!
        tilesList.fetch()
    }

}
