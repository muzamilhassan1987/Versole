//
//  AppDelegate.swift
//  Versole
//
//  Created by Soomro Shahid on 2/20/16.
//  Copyright © 2016 Muzamil Hassan. All rights reserved.
//

import UIKit
import Stripe
import Fabric
import Crashlytics

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    //TEST GIT NOW
    var window: UIWindow?
    var mgSidemenuContainer:MFSideMenuContainerViewController!
    
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // pk_live_IV7jA5OipDLiq0wkBOQb6cki  // LIVE 
        // pk_test_BipPcLXsgat49DcvQMqcprFB  // TEST
        
        Fabric.with([STPAPIClient.self, Crashlytics.self])  
        Stripe.setDefaultPublishableKey("pk_test_BipPcLXsgat49DcvQMqcprFB")
        
        

        NSNotificationCenter.defaultCenter().removeObserver(self)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(AppDelegate.login), name: "login", object: nil)

        // Override point for customization after application launch.
//        for family in UIFont.familyNames()
//        {
//            
//            print("\(family)")
//            
//            for name in UIFont.fontNamesForFamilyName(family as NSString as String)
//            {
//                print("   \(name)")
//            }
//            
//        }
        
//        let notificationTypes: UIUserNotificationType = [UIUserNotificationType.Alert, UIUserNotificationType.Badge, UIUserNotificationType.Sound]
//        let pushNotificationSettings = UIUserNotificationSettings(forTypes: notificationTypes, categories: nil)
//        application.registerUserNotificationSettings(pushNotificationSettings)
//        application.registerForRemoteNotifications()
        
        
        IQKeyboardManager.sharedManager().enable = true
    
        return true
    }
    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
        //print("DEVICE TOKEN = \(deviceToken)")
        let tokenChars = UnsafePointer<CChar>(deviceToken.bytes)
        var tokenString = ""
        
        for i in 0..<deviceToken.length {
            tokenString += String(format: "%02.2hhx", arguments: [tokenChars[i]])
        }
        
        //print("Device Token:", tokenString)
        //NSLog("DeviceToken : %@", tokenString)
        //EZAlertController.alert(tokenString)
        //af386c64458b1883859f832bd0aec36391131830a369c5e569a0e1b1896e549f
    }
    
    //Called if unable to register for APNS.
    func application(application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: NSError) {
        //print("Push Error is")
        //print(error)
        //EZAlertController.alert(error.description)
        
    }
    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
        //print("user info")
        //print(userInfo)
        //EZAlertController.alert(userInfo.description)
    }
    func applicationWillResignActive(application: UIApplication) {
        
        
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    func    login() {
        let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil);
        
            mgSidemenuContainer = mainStoryBoard.instantiateViewControllerWithIdentifier("MFSideMenuContainerViewController") as! MFSideMenuContainerViewController
        
        self.window?.rootViewController = nil;
        self.window?.rootViewController = mgSidemenuContainer
        
        
        let leftViewController = mainStoryBoard.instantiateViewControllerWithIdentifier("LeftSideViewController") as! LeftSideViewController
        
        let centralViewController = mainStoryBoard.instantiateViewControllerWithIdentifier("MenuNavigationController") as! UINavigationController
        
        mgSidemenuContainer.leftMenuViewController = leftViewController
        mgSidemenuContainer.centerViewController = centralViewController
        
    }
    
    func logoutUser() {
        
        if(self.window != nil) {
            self.window = UIWindow.init(frame: UIScreen.mainScreen().bounds)
        }
        let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
        let baseNavigationController = mainStoryBoard.instantiateViewControllerWithIdentifier("BaseNavigationController") as! UINavigationController
        self.window?.rootViewController = baseNavigationController
        self.window?.makeKeyAndVisible()
        NSUserDefaults.standardUserDefaults().setValue(NSNumber(bool: false), forKey: "isLogin")
        NSUserDefaults.standardUserDefaults().removeObjectForKey("userEmail")
        NSUserDefaults.standardUserDefaults().removeObjectForKey("userPassord")
        NSUserDefaults.standardUserDefaults().removeObjectForKey("userDetail")
    }
    
}

