//
//  AppDelegate.swift
//  Astrovedh
//
//  Created by Apple on 16/03/21.
//  Copyright © 2021 Krash. All rights reserved.
//

import UIKit
import Firebase
import CoreData
import FirebaseAuth
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        IQKeyboardManager.shared.enable = true
//        self.checkIfUserIsLoggedIn()
        
        return true
    }
    
//    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool
//    {
//        window=UIWindow(frame: UIScreen.main.bounds)
//        self.window?.rootViewController = setTabbar()
//        self.window?.makeKeyAndVisible()
//        window?.backgroundColor=UIColor.white
//        return true
//    }
//
//    func setTabbar() -> UITabBarController
//    {
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let tabbarcntrl = UITabBarController()
//
//        let Home = storyboard.instantiateViewController(withIdentifier: "HomeView") // 1st tab bar viewcontroller
//        let Followed = storyboard.instantiateViewController(withIdentifier: "FollowedView") // 2nd tab bar viewcontroller
//        let Message = storyboard.instantiateViewController(withIdentifier: "MessageView") // 3rd tab bar viewcontroller
//
//        // all viewcontroller embedded navigationbar
//        let nvHome = UINavigationController(rootViewController: Home)
//        let nvFollowed = UINavigationController(rootViewController: Followed)
//        let nvMessage = UINavigationController(rootViewController: Message)
//
//        // all viewcontroller navigationbar hidden
//        nvHome.setNavigationBarHidden(true, animated: false)
//        nvFollowed.setNavigationBarHidden(true, animated: false)
//        nvMessage.setNavigationBarHidden(true, animated: false)
//
//        tabbarcntrl.viewControllers = [nvHome,nvFollowed,nvMessage]
//
//        let tabbar = tabbarcntrl.tabBar
//        tabbar.barTintColor = UIColor.black
//        tabbar.backgroundColor = UIColor.black
//        tabbar.tintColor = UIColor(red: 43/255, green: 180/255, blue: 0/255, alpha: 1)
//
//        //UITabBar.appearance().tintColor = UIColor.white
//        let attributes = [NSFontAttributeName:UIFont(name: "Montserrat-Light", size: 10)!,NSForegroundColorAttributeName:UIColor.white]
//        let attributes1 = [NSFontAttributeName:UIFont(name: "Montserrat-Light", size: 10)!,NSForegroundColorAttributeName:UIColor(red: 43/255, green: 180/255, blue: 0/255, alpha: 1)]
//
//        UITabBarItem.appearance().setTitleTextAttributes(attributes, for: .normal)
//        UITabBarItem.appearance().setTitleTextAttributes(attributes1, for: .selected)
//
//
//        let tabHome = tabbar.items![0]
//        tabHome.title = "Home" // tabbar titlee
//        tabHome.image=UIImage(named: "icon_home.png")?.withRenderingMode(.alwaysOriginal) // deselect image
//        tabHome.selectedImage = UIImage(named: "icon_home.png")?.withRenderingMode(.alwaysOriginal) // select image
//        tabHome.titlePositionAdjustment.vertical = tabHome.titlePositionAdjustment.vertical-4 // title position change
//
//        let tabFoll = tabbar.items![1]
//        tabFoll.title = "Followed"
//        tabFoll.image=UIImage(named: "icon_fold.png")?.withRenderingMode(.alwaysOriginal)
//        tabFoll.selectedImage=UIImage(named: "icon_fold.png")?.withRenderingMode(.alwaysOriginal)
//        tabFoll.titlePositionAdjustment.vertical = tabFoll.titlePositionAdjustment.vertical-4
//
//        let tabMsg = tabbar.items![3]
//        tabMsg.title = "Message"
//        tabMsg.image=UIImage(named: "icon_mail.png")?.withRenderingMode(.alwaysOriginal)
//        tabMsg.selectedImage=UIImage(named: "icon_mail.png")?.withRenderingMode(.alwaysOriginal)
//        tabMsg.titlePositionAdjustment.vertical = tabMsg.titlePositionAdjustment.vertical-4
//
//        return tabbarcntrl
//    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "Astrovedh")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

