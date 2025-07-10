//  File: SelectGenreTableVC.swift
//  Project: Project33-WhatsThatWhistle
//  Created by: Noah Pope on 7/5/25.

import UIKit

//enum Genres: CaseIterable // protocol allows for us to access '.count' prop for #OfCells
//{
//    case Unknown, Blues, Classical, Electronic, Jazz, Metal, Pop, Reggae, RnB, Rock, Soul
//}

class SelectGenreTableVC: UITableViewController
{
    static var genres = ["Unknown", "Blues", "Classical", "Electronic", "Jazz", "Metal", "Pop", "Reggae", "RnB", "Rock", "Soul"]
    
    class func sayHello(){print("hey")}
    
    
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
    { return 1 }

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    { return SelectGenreTableVC.genres.count }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = SelectGenreTableVC.genres[indexPath.row]
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        if let cell = tableView.cellForRow(at: indexPath) {
            let genre = cell.textLabel?.text ?? SelectGenreTableVC.genres[0]
            let vc = AddCommentsVC()
            vc.genre = genre
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
