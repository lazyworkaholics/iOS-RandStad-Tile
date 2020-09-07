//
//  ServiceManagerProtocol.swift
//  RandStadPOC
//
//  Created by Harsha VARDHAN on 02/09/2020.
//  Copyright © 2020 Harsha VARDHAN. All rights reserved.
//

import Foundation

protocol ServiceManagerProtocol {

    static var sharedInstance:ServiceManagerProtocol {get set}
    
    func getTilesList(onSuccess successBlock:@escaping ([Tile]) -> Void,
                      onFailure failureBlock:@escaping (NSError) -> Void)
    
    func getMessage(_ contactId:String,
                    onSuccess successBlock:@escaping (TileMessage)->Void,
                    onFailure failureBlock:@escaping (NSError)->Void)
}
