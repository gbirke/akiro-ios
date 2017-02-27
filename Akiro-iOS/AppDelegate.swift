//
//  AppDelegate.swift
//  Erster Test
//
//  Created by Gabriel Birke on 24.02.17.
//  Copyright © 2017 Gabriel Birke. All rights reserved.
//

import UIKit
import CoreData

let persistentConatiner:NSPersistentContainer = {
    let container = NSPersistentContainer(name: "ExpenseTracker")
    container.loadPersistentStores() {
        (storeDescription, error ) in
        
        if let error = error {
            let nserror = error as NSError
            print("Database init error: \(nserror.localizedDescription)")
        }
    }
    return container
}()

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    
    
    var payeeRessource = CoreDataPayeeResource(withContainer: persistentConatiner)
    var categoryRessource = CoreDataCategoryResource(withContainer: persistentConatiner)
    var expenseRessource = CoreDataExpenseResource(withContainer: persistentConatiner)


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        preloadData()
        
        // Override point for customization after application launch.
        return true
    }

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
    }

    func preloadData() {
        if UserDefaults.standard.bool(forKey: "isPreloaded") {
            return
        }
        categoryRessource.initializeFromCSV(preloadUrl: Bundle.main.url(forResource: "categories", withExtension: "csv"))
        
        UserDefaults.standard.set(true, forKey: "isPreloaded")
        
    }

}

