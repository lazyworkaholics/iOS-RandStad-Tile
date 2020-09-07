//
//  TileList.swift
//  RandStadPOC
//
//  Created by Harsha VARDHAN on 05/09/2020.
//  Copyright © 2020 Harsha VARDHAN. All rights reserved.
//

import Foundation

enum TileServiceEvent: String {
    case ListFetch
    case MessageFetch
}

class TileList {

    var tiles: [Tile]?
    
    lazy var serviceManager: ServiceManagerProtocol = ServiceManager.sharedInstance
    
    var tileListObserver: (([Tile], TileServiceEvent) -> Void)?
    var errorObserver: ((NSError, TileServiceEvent) -> Void)?

    init(_ tilesObserver:@escaping ([Tile], TileServiceEvent) -> Void, errorObserver: @escaping (NSError, TileServiceEvent) -> Void) {

        self.tileListObserver = tilesObserver
        self.errorObserver = errorObserver
    }
    
    func fetch() {
        self.serviceManager.getTilesList(onSuccess: {(tiles) in

            self.tiles = tiles
//            self.tiles = tiles.sorted(by: { $0.priority < $1.priority })
            self.tileListObserver?(self.tiles!, TileServiceEvent.ListFetch)
        }, onFailure: {(error) in

            self.errorObserver?(error, TileServiceEvent.ListFetch)
        })
    }
    
}

