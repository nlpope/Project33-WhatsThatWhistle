//  File: HomeVC.swift
//  Project: Project33-WhatsThatWhistle
//  Created by: Noah Pope on 6/22/25.

import UIKit

class HomeVC: UIViewController
{
    var logoLauncher: WWLogoLauncher!
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        PersistenceManager.isFirstVisitAfterDismissal = true
        configNavigation()
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
    
    //-------------------------------------//
    // MARK: - CONFIGURATION
    
    func configNavigation()
    {
        title = "What's theat Whistle?"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addWhistle))
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Home", style: .plain, target: nil, action: nil)
    }
    
    
    @objc func addWhistle()
    {
        let vc = RecordWhistleVC()
        navigationController?.pushViewController(vc, animated: true)
    }
}
