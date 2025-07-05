//  File: SelectGenreTableVC.swift
//  Project: Project33-WhatsThatWhistle
//  Created by: Noah Pope on 7/5/25.

import UIKit

enum Genres
{
    case Unknown, Blues, Classical, Electronic, Jazz, Metal, Pop, Reggae, RnB, Rock, Soul
}

class SelectGenreTableVC: UITableViewController
{
//    static var genres = ["Unknown", "Blues", "Classical"]
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        configNavigation()
        configTableView()
    }
    
    //-------------------------------------//
    // MARK: - CONFIGURATION
    
    func configNavigation()
    {
        title = "Select Genre"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Genre", style: .plain, target: nil, action: nil)
    }
    
    
    func configTableView()
    {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }

    //-------------------------------------//
    // MARK: - TABLE VIEW DATA SOURCE METHODS

    override func numberOfSections(in tableView: UITableView) -> Int
    { return 0 }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    { return 0 }
}
