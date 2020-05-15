//
//  AppDelegate.swift
//  whatToEat
//
//  Created by mac on 24.03.2020.
//  Copyright © 2020 Aleksandr Balabon. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    let baseViewController = BaseViewController()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
       loadData()
        return true
    }
   
}

