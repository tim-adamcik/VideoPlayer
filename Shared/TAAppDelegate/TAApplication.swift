//
//  TAApplication.swift
//  TimTestVideoPlayer
//
//  Created by Timothy Adamcik on 6/10/22.
//

import UIKit

private var _isInitialLaunch: Bool = false
private var _wasUpdated: Bool = false

// MARK: - FLIApplication
protocol TAApplication {
    var delegate: TADelegateMulticast<TAApplicationDelegate> { get set }
    var ipAddressV4: String? { get set }
    var isInitialLaunch: Bool { get }
}

extension TAApplication {
    
    /// `String` representing the devices external version 4 IP address.
    /// - Note: Classes that conform to the `FLIApplication` protocol are responsible for setting this value. Value is `nil` by default..
    var ipAddressV4: String? {
        get { return nil }
        set { }
    }
    
}

// MARK: - FLIApplicationDelegate
protocol TAApplicationDelegate: AnyObject {
    func applicationDidFinishLaunching()
    func applicationWillResignActive()
    func applicationDidEnterBackground()
    func applicationWillEnterForeground()
    func applicationDidBecomeActive()
    func applicationWillTerminate()
    func applicationDidUpdate()
    func applicationDidLaunchFromNotification()
    func applicationDidReceiveNotificationWhileActive()
    
}

extension TAApplicationDelegate {
    
    func applicationDidFinishLaunching() {
        let _ = UIApplication.fli?.isInitialLaunch
    }
    
    func applicationWillResignActive() {
        _isInitialLaunch = false
        _wasUpdated = false
    }
    
    func applicationDidEnterBackground() { }
    func applicationWillEnterForeground() { }
    func applicationDidBecomeActive() { }
    func applicationWillTerminate() { }
    func applicationDidUpdate() { }
    func applicationDidLaunchFromNotification() { }
    func applicationDidReceiveNotificationWhileActive() { }
    
}
