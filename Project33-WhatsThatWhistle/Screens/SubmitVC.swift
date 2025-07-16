//  File: SubmitVC.swift
//  Project: Project33-WhatsThatWhistle
//  Created by: Noah Pope on 7/10/25.

/**
 this view controller has only one job: to show the user that iCloud submission is happening until it completes
 */

import UIKit
import CloudKit

class SubmitVC: UIViewController
{
    var genre: String!
    var comments: String!
    var stackView: UIStackView!
    var status: UILabel!
    var spinner: UIActivityIndicatorView!
    
    #warning("why configing ui in loadView & not VDL?")
    override func loadView() { configUI() }
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        configNavigation()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        doSubmission()
    }
    
    //-------------------------------------//
    // MARK: - CONFIGURATION
    
    func configUI()
    {
        view = UIView()
        view.backgroundColor = UIColor.gray
        
        stackView = UIStackView()
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = UIStackView.Distribution.fillEqually
        stackView.alignment = .center
        stackView.axis = .vertical
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        status = UILabel()
        status.translatesAutoresizingMaskIntoConstraints = false
        status.text = "Submitting..."
        status.textColor = UIColor.white
        status.font = UIFont.preferredFont(forTextStyle: .title1)
        status.numberOfLines = 0
        status.textAlignment = .center
        
        spinner = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.hidesWhenStopped = true
        spinner.startAnimating()
        
        stackView.addArrangedSubview(status)
        stackView.addArrangedSubview(spinner)
    }
    
    
    func configNavigation()
    {
        title = "You're all set!"
        navigationItem.hidesBackButton = true
    }
    
    //-------------------------------------//
    // MARK: - SUBMISSION
    
    func doSubmission()
    {
        let whistleRecord = CKRecord(recordType: "Whistles")
        whistleRecord["genre"] = genre as CKRecordValue
        whistleRecord["comments"] = comments as CKRecordValue
        
        let audioURL = RecordWhistleVC.getWhistleURL()
        let whistleAsset = CKAsset(fileURL: audioURL)
        whistleRecord["audio"] = whistleAsset
        
        CKContainer(identifier: DirectoryKeys.iCloudContainer).publicCloudDatabase.save(whistleRecord) { [unowned self] record, error in
            DispatchQueue.main.async {
                if let error = error {
                    self.status.text = "Error: \(error)"
                    self.spinner.stopAnimating()
                } else {
                    self.view.backgroundColor = UIColor(red: 0, green: 0.6, blue: 0, alpha: 1)
                    self.status.text = "Done!"
                    self.spinner.stopAnimating()
                    
                    HomeVC.isDirty = true
                }
                
                self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.doneTapped))
            }
        }
    }
    
    
    @objc func doneTapped() { _ = navigationController?.popToRootViewController(animated: true) }
}
