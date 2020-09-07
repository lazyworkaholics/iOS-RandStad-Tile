//
//  AppDelegate.swift
//  RandStadPOC
//
//  Created by Harsha VARDHAN on 02/09/2020.
//  Copyright © 2020 Harsha VARDHAN. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var appRouter:RouterProtocol = Router.sharedInstance
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow(frame: UIScreen.main.bounds)
        appRouter.appLaunch(window!)
        return true
    }
}

