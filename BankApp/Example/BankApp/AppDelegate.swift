//
//  AppDelegate.swift
//  BankApp
//
//  Created by viniteixeira on 08/23/2021.
//  Copyright (c) 2021 viniteixeira. All rights reserved.
//

import UIKit
import BankApp

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let loginViewController = Login.ViewController()
        window?.rootViewController = loginViewController
        window?.makeKeyAndVisible()
        
        return true
    }
}

