//  File: AppDelegate.swift
//  Project: Project33-WhatsThatWhistle
//  Created by: Noah Pope on 6/22/25.

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate
{
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool { return true }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration
    {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {}

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "Project33_WhatsThatWhistle")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext ()
    {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

//-------------------------------------//
// MARK: - NOTES SECTION

/**
 swift @ version: 6 (released 09.17.2024)
 iOS @ version: 18.5 (released 05.14.2025)
 xcode @ version: 16.3 (released 03.31.2025)
 --------------------------
 XXXXXXXXXXXXXXXXXXXXXXXX
 --------------------------
 PROBLEM TRACKING:
 * = problem
 >  = solution
 --------------------------
 * can't seem to find the m4a file from the recording
 > try launching in simulator post completion to see if this is present, but should be apparent when I get to playback section
 > unsuccessful but the file is successfully playing back so I will leave it be for now
 --------------------------
 * replacement for depricated 'recordFetchedBlock method in HomeVC doesn't contain 'recordID' prop
 > reading through documentation and maybe the name is the replaced value which means I'd have to change the type in the model
 
 *having trouble with another deprecated method in the same file as well. will look into this.
 --------------------------
 XXXXXXXXXXXXXXXXXXXXXXXX
 --------------------------
 TECHNOLOGIES USED / LEARNED:
 * Swift
 * XCode
 * MIT's Swift Keychain Wrapper
 * Bakery (App Icon)
 --------------------------
 XXXXXXXXXXXXXXXXXXXXXXXX
 --------------------------
 HORNS-TO-TOOT::
 🎺
 --------------------------
 XXXXXXXXXXXXXXXXXXXXXXXX
 --------------------------
 REFERENCES & CREDITS:
 * KeychainOptions.swift & SwiftKeychainWrapper by MIT's James Blair on 4/24/16.
 * Bakery was developed by Jordi Bruin: https://x.com/jordibruin
 --------------------------
 XXXXXXXXXXXXXXXXXXXXXXXX
 --------------------------
 */
