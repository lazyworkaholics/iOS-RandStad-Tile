//
//  NetworkManagerMock.swift
//  RandStadPOC
//
//  Created by Harsha VARDHAN on 05/09/2020.
//  Copyright © 2020 Harsha VARDHAN. All rights reserved.
//

import UIKit
@testable import RandStadPOC

class NetworkManagerMock: NetworkManagerProtocol {

    var data: Data?
    var error: NSError?
    var isSuccess: Bool?
    
    static var sharedInstance:NetworkManagerProtocol = NetworkManagerMock()
    
    func httpRequest(_ urlPath:String,
                     params: [String: String]?,
                     method: HTTPRequestType,
                     headers: [String:String]?,
                     body: Data?,
                     onSuccess successBlock:@escaping (Data)->Void,
                     onFailure failureBlock:@escaping (NSError)->Void)
    {
        
        if isSuccess!
        {
            successBlock(data!)
        }
        else
        {
            failureBlock(error!)
        }
    }
}
