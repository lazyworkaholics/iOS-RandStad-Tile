//
//  ServiceManagerMock.swift
//  RandStadPOCTests
//
//  Created by Harsha VARDHAN on 05/09/2020.
//  Copyright © 2020 Harsha VARDHAN. All rights reserved.
//

import Foundation
@testable import RandStadPOC

class ServiceManagerMock: ServiceManagerProtocol {
    
    static var sharedInstance: ServiceManagerProtocol = ServiceManagerMock()
    
    //stubs for getTilesList
    var tilesList:[Tile]?
    var getList_error:NSError?
    var is_getList_Success: Bool?
    
    var is_getList_SuccessBlock_invoked = false
    var is_getList_FailureBlock_invoked = false
    
    //stubs for getMessage
    var tileMessage:TileMessage?
    var getMessage_error:NSError?
    var is_getMessage_Success: Bool?
    
    var is_getMessage_SuccessBlock_invoked = false
    var is_getMessage_FailureBlock_invoked = false
    
    func getTilesList(onSuccess successBlock: @escaping ([Tile]) -> Void, onFailure failureBlock: @escaping (NSError) -> Void) {
        
        if is_getList_Success!
        {
            is_getList_SuccessBlock_invoked = true
            is_getList_FailureBlock_invoked = false
            successBlock(tilesList!)
        }
        else
        {
            is_getList_SuccessBlock_invoked = false
            is_getList_FailureBlock_invoked = true
            failureBlock(getList_error!)
        }
    }
    
    func getMessage(_ contactId: String, onSuccess successBlock: @escaping (TileMessage) -> Void, onFailure failureBlock: @escaping (NSError) -> Void) {
        if is_getMessage_Success!
        {
            is_getMessage_SuccessBlock_invoked = true
            is_getMessage_FailureBlock_invoked = false
            successBlock(tileMessage!)
        }
        else
        {
            is_getMessage_SuccessBlock_invoked = false
            is_getMessage_FailureBlock_invoked = true
            failureBlock(getMessage_error!)
        }
    }
}
