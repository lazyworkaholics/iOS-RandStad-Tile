//
//  TileMessageTests.swift
//  RandStadPOCTests
//
//  Created by Harsha VARDHAN on 05/09/2020.
//  Copyright © 2020 Harsha VARDHAN. All rights reserved.
//

import XCTest
@testable import RandStadPOC

class TileMessageTests: XCTestCase {
    
    func test_NotEqualElements_comparision() {
        
        let tileMessage1 = TileMessage.init("message1")
        let tileMessag2 = TileMessage.init("message2")
        
        if tileMessage1 != tileMessag2 {
            XCTAssert(true)
        }
        else {
            XCTFail()
        }
        
        if tileMessage1 == tileMessag2 {
            XCTFail()
        }
        else {
            XCTAssert(true)
        }
    }
    
    func test_equalElements_comparision() {
        
        let tileMessage1 = TileMessage.init("message1")
        let tileMessag2 = TileMessage.init("message1")
        
        if tileMessage1 != tileMessag2 {
            XCTFail()
        }
        else {
            XCTAssert(true)
        }
        
        if tileMessage1 == tileMessag2 {
            XCTAssert(true)
        }
        else {
             XCTFail()
        }
    }

}
