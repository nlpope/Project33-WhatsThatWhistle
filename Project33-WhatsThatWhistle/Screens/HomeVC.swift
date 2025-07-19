//  File: HomeVC.swift
//  Project: Project33-WhatsThatWhistle
//  Created by: Noah Pope on 6/22/25.

import UIKit
import CloudKit

class HomeVC: UITableViewController
{
    var logoLauncher: WWLogoLauncher!
    var whistles = [WWWhistle]()
    static var isDirty = true
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        PersistenceManager.isFirstVisitAfterDismissal = true
        configNavigation()
        configTableView()
    }
    
    
    override func viewWillAppear(_ animated: Bool)
    {
        logoLauncher = WWLogoLauncher(targetVC: self)
        if PersistenceManager.fetchFirstVisitAfterDismissalStatus() {
            logoLauncher.configLogoLauncher()
        } else {
            if let indexPath = tableView.indexPathForSelectedRow {
                tableView.deselectRow(at: indexPath, animated: true)
            }
            if HomeVC.isDirty { loadWhistles() }
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
    
    
    func configTableView()
    {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    
    //-------------------------------------//
    // MARK: - DATA HANDLING
    
    @objc func addWhistle()
    {
        let vc = RecordWhistleVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func loadWhistles()
    {
        // cloudkit pt1
        let pred = NSPredicate(value: true)
        let sort = NSSortDescriptor(key: "creationDate", ascending: false)
        
        let query = CKQuery(recordType: "Whistles", predicate: pred)
        query.sortDescriptors = [sort]
        
        let operation = CKQueryOperation(query: query)
        operation.desiredKeys = ["genre", "comments"]
        operation.resultsLimit = 50
        
        var newWhistles = [WWWhistle]()
        
        // cloudkit pt2
        #warning("un-depricated method won't read recordID. WHY?")
        operation.recordFetchedBlock = { record in
            let whistle = WWWhistle()
            whistle.recordID = record.recordID
            whistle.genre = record["genre"]
            whistle.comments = record["comments"]
            newWhistles.append(whistle)
        }
        
        // cloudkit pt3
        operation.queryCompletionBlock = { [unowned self] (cursor, error) in
            DispatchQueue.main.async {
                if error == nil {
                    HomeVC.isDirty = false
                    self.whistles = newWhistles
                    self.tableView.reloadData()
                } else {
                    let ac = UIAlertController(title: "Fetch failed", message: "\(MessageKeys.fetchFail):\(error!)", preferredStyle: .alert)
                    ac.addAction(UIAlertAction(title: "OK", style: .default))
                    self.present(ac, animated: true)
                }
            }
        }
        
        // cloudkit pt4
        CKContainer.default().publicCloudDatabase.add(operation)
    }
    
    //-------------------------------------//
    // MARK: - SUPPORTING METHODS
    
    func makeAttributedString(title: String, subtitle: String) -> NSAttributedString
    {
        let titleAttributes = [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .headline), NSAttributedString.Key.foregroundColor: UIColor.purple]
        let subtitleAttributes = [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .subheadline)]
        
        let titleString = NSMutableAttributedString(string: "\(title)", attributes: titleAttributes)
        
        if subtitle.count > 0 {
            let subtitleString = NSAttributedString(string: "\n\(subtitle)", attributes: subtitleAttributes)
            titleString.append(subtitleString)
        }
        
        return titleString
    }
    
    //-------------------------------------//
    // MARK: - TABLEVIEW DATASOURCE & DELEGATE METHODS
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return self.whistles.count }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.attributedText = makeAttributedString(title: whistles[indexPath.row].genre, subtitle: whistles[indexPath.row].comments)
        cell.textLabel?.numberOfLines = 0
        return cell
    }
}
