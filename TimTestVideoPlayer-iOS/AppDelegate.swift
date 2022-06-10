//
//  AppDelegate.swift
//  TimTestVideoPlayer
//
//  Created by Timothy Adamcik on 6/10/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate, TAApplication {
    var ipAddressV4: String? = String()
    var isInitialLaunch: Bool = true
    
    var delegate: TADelegateMulticast<TAApplicationDelegate> = TADelegateMulticast<TAApplicationDelegate>()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        delegate.invoke({ $0.applicationWillResignActive() })
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        delegate.invoke({ $0.applicationDidEnterBackground() })
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        delegate.invoke({ $0.applicationWillEnterForeground() })
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        delegate.invoke({ $0.applicationDidBecomeActive() })
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        delegate.invoke({ $0.applicationWillTerminate() })
    }
    
    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

