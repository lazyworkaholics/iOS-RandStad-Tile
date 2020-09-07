//
//  ServiceManagerTests.swift
//  RandStadPOCTests
//
//  Created by Harsha VARDHAN on 05/09/2020.
//  Copyright © 2020 Harsha VARDHAN. All rights reserved.
//

import XCTest

@testable import RandStadPOC

class ServiceManagerTests: XCTestCase {
    
    var serviceManagerToTest: ServiceManager?
    var mockNetworkManager:NetworkManagerMock?
    
    var mockTile:Tile?
    var testError:NSError?
    
    var mockTileMessage:TileMessage?
    
    override func setUp() {
        
        mockTile = Tile.init("Test_Id", label: "Test_Lable", priority: 0.5)
        
        testError = NSError.init(domain: "com.testingErrorDomain",
                                 code: 11010101843834,
                                 userInfo: [NSLocalizedDescriptionKey:"Mock constructed Error"])
        
        mockTileMessage = TileMessage.init("Test_message")
        
        serviceManagerToTest = ServiceManager.sharedInstance as? ServiceManager
        mockNetworkManager = NetworkManagerMock.sharedInstance as? NetworkManagerMock
        mockNetworkManager?.error = testError
    }
    
    override func tearDown() {

        mockTile = nil
        testError = nil
        mockNetworkManager = nil
        serviceManagerToTest?.networkManager = NetworkManager.sharedInstance
    }
    
    func testGetTilesList_Failed() {
        
        mockNetworkManager?.isSuccess = false
        
        serviceManagerToTest?.networkManager = mockNetworkManager!
        serviceManagerToTest?.getTilesList(onSuccess: { (tiles) in
            
            XCTFail("Success block should not be called if there is an internal network error.")
        }, onFailure: { (error) in
            
            XCTAssertEqual(error, self.testError!, "getTilesList function is not returning the exact error as retured by NetworkManager")
        })
    }
    
    func testGetTilesList_ValidData() {
        
        let encoder = JSONEncoder.init()
        do {
            let mockData = try encoder.encode([mockTile])
            
            mockNetworkManager?.data = mockData
            mockNetworkManager?.isSuccess = true
            
            serviceManagerToTest?.networkManager = mockNetworkManager!
            serviceManagerToTest?.getTilesList(onSuccess: { (tiles) in
                
                XCTAssertEqual(tiles, [self.mockTile], "failed to parse the given data into required model")
            }, onFailure: { (error) in
                
                XCTFail("Failure block should not be called when network manager returns a valid data object.")
            })
        } catch {
            print(error)
        }
    }
    
    func testGetMessage_Failed() {
        
        mockNetworkManager?.isSuccess = false
        
        serviceManagerToTest?.networkManager = mockNetworkManager!
        serviceManagerToTest?.getMessage(mockTile!.id, onSuccess: { (tiles) in
            
            XCTFail("Success block should not be called if there is an internal network error.")
        }, onFailure: { (error) in
            
            XCTAssertEqual(error, self.testError!, "getTilesList function is not returning the exact error as retured by NetworkManager")
        })
    }
    
    func testGetMessage_Success() {
        
        let encoder = JSONEncoder.init()
        do {
            let mockData = try encoder.encode(mockTileMessage)
            
            mockNetworkManager?.data = mockData
            mockNetworkManager?.isSuccess = true
            
            serviceManagerToTest?.networkManager = mockNetworkManager!
            serviceManagerToTest?.getMessage(mockTile!.id, onSuccess: { (tileMessage) in
                
                XCTAssertEqual(tileMessage, self.mockTileMessage, "failed to parse the given data into required model")
            }, onFailure: { (error) in
                
                XCTFail("Failure block should not be called when network manager returns a valid data object.")
            })
        } catch {
            print(error)
        }
    }
}
