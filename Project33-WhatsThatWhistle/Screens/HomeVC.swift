//  File: HomeVC.swift
//  Project: Project33-WhatsThatWhistle
//  Created by: Noah Pope on 6/22/25.

import UIKit
import AVKit
import AVFoundation

class HomeVC: UIViewController
{
    var logoLauncher: WWLogoLauncher!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        PersistenceManager.isFirstVisitAfterDismissal = true
    }
    
    
    override func viewWillAppear(_ animated: Bool)
    {
        logoLauncher = WWLogoLauncher(targetVC: self)
        if PersistenceManager.fetchFirstVisitAfterDismissalStatus() {
            logoLauncher.configLogoLauncher()
        } else {
            // fetch relevant Info
        }
    }
    
    
    override func viewWillDisappear(_ animated: Bool) { logoLauncher = nil }
    
    
    deinit { logoLauncher.removeAllAVPlayerLayers(); logoLauncher.removeNotifications() }
}
