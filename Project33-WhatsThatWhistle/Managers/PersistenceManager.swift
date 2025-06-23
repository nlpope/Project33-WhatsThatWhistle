//  File: PersistenceManager.swift
//  Project: Project33-WhatsThatWhistle
//  Created by: Noah Pope on 6/23/25.

import Foundation

enum PersistenceManager
{
    static private let defaults = UserDefaults.standard
    static var isFirstVisitAfterDismissal: Bool! = fetchFirstVisitAfterDismissalStatus() {
        didSet { PersistenceManager.saveFirstVisitStatus(status: self.isFirstVisitAfterDismissal) }
    }
    
    //-------------------------------------//
    // MARK: - SAVE / FETCH FIRST VISIT STATUS (FOR LOGO LAUNCHER)
    
    static func saveFirstVisitStatus(status: Bool)
    {
        do {
            let encoder = JSONEncoder()
            let encodedStatus = try encoder.encode(status)
            defaults.set(encodedStatus, forKey: PersistenceKeys.isFirstVisitAfterDismissal)
        } catch {
            print("failed ato save visit status"); return
        }
    }
    
    
    static func fetchFirstVisitAfterDismissalStatus() -> Bool
    {
        guard let visitStatusData = defaults.object(forKey: PersistenceKeys.isFirstVisitAfterDismissal) as? Data
        else { return true }
        
        do {
            let decoder = JSONDecoder()
            let fetchedStatus = try decoder.decode(Bool.self, from: visitStatusData)
            return fetchedStatus
        } catch {
            print("unable to load first visit status")
            return true
        }
    }
}
