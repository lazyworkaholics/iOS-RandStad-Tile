//
//  ServiceManager.swift
//  RandStadPOC
//
//  Created by Harsha VARDHAN on 02/09/2020.
//  Copyright © 2020 Harsha VARDHAN. All rights reserved.
//

import Foundation

class ServiceManager: ServiceManagerProtocol {
    
    static var sharedInstance:ServiceManagerProtocol = ServiceManager()
    var networkManager:NetworkManagerProtocol
    
    private init() {
        networkManager = NetworkManager.sharedInstance
    }
    
    //MARK: - Core functions to handle webservices
    public func getTilesList(onSuccess successBlock:@escaping ([Tile]) -> Void,
                             onFailure failureBlock:@escaping (NSError) -> Void) {
        
        _networkRequest(urlPath: "tiles",
                        params: nil,
                        method: .GET,
                        headers: nil,
                        body: nil,
                        onSuccess: { (tiles) in
                                            
                            successBlock(tiles)
                        },
                        onFailure: { (error) in

                            failureBlock(error)
                        })
    }
    
    public func getMessage(_ contactId:String,
                           onSuccess successBlock:@escaping (TileMessage)->Void,
                           onFailure failureBlock:@escaping (NSError)->Void) {
        
        _networkRequest(urlPath: Network_Constants.SELECTION_PATH,
                        params: ["id" : contactId],
                        method: .POST,
                        headers: [
                                "Content-Length":"0",
                                "host":"127.0.0.1:9235",
                                  "Content-Type":"text/plain; charset=utf-8",
                                  "Accept":"application/json"],
                        body: nil,
                        onSuccess: { (tileMessage) in
                            
                            successBlock(tileMessage)
                        },
                        onFailure:  { (error) in
                            
                            failureBlock(error)
                        })
    }
    
    //MARK: - Internal functions
    private func _networkRequest<T:Codable>(urlPath:String,
                                           params: [String: String]?,
                                           method: HTTPRequestType,
                                           headers: [String: String]?,
                                           body: Data?,
                                           onSuccess successBlock:@escaping (T)->Void,
                                           onFailure failureBlock:@escaping (NSError)->Void) {
        
        networkManager.httpRequest(urlPath, params: params, method: method, headers: headers,
                                   body: body,
                                   onSuccess: { (data) in
                                    
                                    let decoder = JSONDecoder.init()
                                    do {
                                        let transformedData =  try decoder.decode(T.self, from: data)
                                        successBlock(transformedData)
                                    } catch {
                                        failureBlock(error as NSError)
                                    }
        },
                                   onFailure: { (error) in
                                    
                                    failureBlock(error)
        })
    }
}
