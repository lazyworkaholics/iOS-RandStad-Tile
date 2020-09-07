//
//  Router.swift
//  RandStadPOC
//
//  Created by Harsha VARDHAN on 05/09/2020.
//  Copyright © 2020 Harsha VARDHAN. All rights reserved.
//

import Foundation
import UIKit


class Router: RouterProtocol {

    static var sharedInstance:Router = Router()
    
    var rootNavigationController:UINavigationController?
    var listViewModel:ListViewModel?
    
    func appLaunch(_ window:UIWindow) {
        
        self.listViewModel = ListViewModel.init()
        let listViewController = ListViewController.initWithViewModel(self.listViewModel!)
        
        UINavigationBar.appearance().tintColor = UIColor.init(named: StringConstants.Colors.APP_COLOR)
        self.rootNavigationController = UINavigationController(rootViewController: listViewController)
        
        window.tintColor = UIColor.init(named: StringConstants.Colors.APP_COLOR)
        window.rootViewController = self.rootNavigationController!
        window.makeKeyAndVisible()
        
        self.listViewModel!.fetch()
    }
}
