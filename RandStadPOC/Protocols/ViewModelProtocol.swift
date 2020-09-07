//
//  ViewModelProtocol.swift
//  RandStadPOC
//
//  Created by Harsha VARDHAN on 05/09/2020.
//  Copyright © 2020 Harsha VARDHAN. All rights reserved.
//

import Foundation

protocol ViewModelProtocol {
    
    func showStaticAlert(_ title: String, message: String)
    func showLoadingIndicator()
    func hideLoadingIndicator()
    func reloadUI()
}
