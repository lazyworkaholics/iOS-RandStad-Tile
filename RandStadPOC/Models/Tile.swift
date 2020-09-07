//
//  Contact.swift
//  RandStadPOC
//
//  Created by Harsha VARDHAN on 02/09/2020.
//  Copyright © 2020 Harsha VARDHAN. All rights reserved.
//

class Tile: Codable, Equatable {
    
    var id: String!
    var label: String!
    var priority: Double!
    var message: String?
    
    lazy var serviceManager: ServiceManagerProtocol = ServiceManager.sharedInstance
    
    var messageObserver: ((String?, NSError?, TileServiceEvent)-> Void)?
    
    init(_ id: String!, label: String, priority: Double) {
        
        self.id = id
        self.label = label
        self.priority = priority
    }
    
    //MARK:- Codable and Equatable confirmations
    enum CodingKeys: String, CodingKey {
        
        case id = "Id"
        case label = "Label"
        case priority = "Priority"
    }
    
    public static func == (lhs: Tile, rhs: Tile) -> Bool {
        
        if (lhs.id == rhs.id) &&
            (lhs.label == rhs.label) &&
            (lhs.priority == rhs.priority) &&
            (lhs.message == rhs.message)
        {
            return true
        }
        return false
    }
    
    public static func != (lhs: Tile, rhs: Tile) -> Bool {
        if  (lhs.id != rhs.id) ||
            (lhs.label != rhs.label) ||
            (lhs.priority != rhs.priority) ||
            (lhs.message != rhs.message)
        {
            return true
        }
        return false
    }
    
    //MARK:- Get Message from Service
    func fetchMessage() {
        self.serviceManager.getMessage(id, onSuccess: { (tileMessage) in
            
            self.message = tileMessage.message
            self.messageObserver?(self.message, nil, TileServiceEvent.MessageFetch)
        }, onFailure:  { (error) in
            
            self.messageObserver?(nil, error, TileServiceEvent.MessageFetch)
        })
    }
}

struct TileMessage:Codable, Equatable {
    
    var message: String?
    
    init(_ message: String!) {
        
        self.message = message
    }
    
    public static func == (lhs: TileMessage, rhs: TileMessage) -> Bool {
        
        if (lhs.message == rhs.message) {
            return true
        }
        return false
    }
    
    public static func != (lhs: TileMessage, rhs: TileMessage) -> Bool {
        
        if (lhs.message != rhs.message) {
            return true
        }
        return false
    }
}
