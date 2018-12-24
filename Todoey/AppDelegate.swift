//
//  AppDelegate.swift
//  Todoey
//
//  Created by Appolar on 29/10/18.
//  Copyright © 2018 Appolar. All rights reserved.
//

import UIKit

import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
     
        //print(Realm.Configuration.defaultConfiguration.fileURL)
        


        do {
           _ = try Realm()
        } catch {
            print("Error initialising new Realm, \(error)")
        }
        
        
        
        return true
    }

   

    

}

