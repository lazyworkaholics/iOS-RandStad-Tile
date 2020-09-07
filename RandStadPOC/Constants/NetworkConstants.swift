//
//  AppConstants.swift
//  RandStadPOC
//
//  Created by Harsha VARDHAN on 05/09/2020.
//  Copyright © 2020 Harsha VARDHAN. All rights reserved.
//

struct Network_Constants {
    static let BASE_URL = "http://127.0.0.1:9235/"
    
    static let TILES_LIST_PATH = "tiles"
    static let SELECTION_PATH = "selection"
}

struct Network_Error_Constants {
    static let ERROR_DOMAIN = "com.networkErrorDomain"
    static let URLSESSION_ERROR = 0
    static let NOT_REACHABLE = 1
    static let PARSING_ERROR = 2
    static let EDIT_CONTACT_NOCHANGES_ERROR = 3
    static let LOCAL_ERROR_DOMAIN = "com.randStad.localErrorDomain"
    static let EDIT_CONTACT_NOCHANGES_LOCAL_DESCRIPTION = "There are no changes in this contact to push."
}
