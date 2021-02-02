//
//  AppDelegate.swift
//  PaintedMan
//
//  Created by ООО АКИП on 12.12.17.
//  Copyright © 2017 GuessWho. All rights reserved.
//

import UIKit
import Firebase
import GoogleMobileAds

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        GADMobileAds.sharedInstance().start(completionHandler: nil)
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        SoundDelegate.pauseBackgroundMusic()
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        SoundDelegate.resumeBackgroundMusic()
    }

    func applicationWillTerminate(_ application: UIApplication) {
        SoundDelegate.stopBackgroundMusic()
    }


}

