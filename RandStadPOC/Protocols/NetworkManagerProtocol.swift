//
//  NetworkManagerProtocol.swift
//  RandStadPOC
//
//  Created by Harsha VARDHAN on 05/09/2020.
//  Copyright © 2020 Harsha VARDHAN. All rights reserved.
//

import Foundation

protocol NetworkManagerProtocol {
    
    static var sharedInstance:NetworkManagerProtocol {get set}
    
    func httpRequest(_ urlPath:String,
                     params: [String: String]?,
                     method: HTTPRequestType,
                     headers: [String: String]?,
                     body: Data?,
                     onSuccess successBlock:@escaping (Data)->Void,
                     onFailure failureBlock:@escaping (NSError)->Void)
}
