//  File: RecordWhistleVC.swift
//  Project: Project33-WhatsThatWhistle
//  Created by: Noah Pope on 6/23/25.

import UIKit
import AVFoundation

class RecordWhistleVC: UIViewController
{
    var stackView: UIStackView!
    var recordButton: UIButton!
    var recordingSession: AVAudioSession!
    var whistleRecorder: AVAudioRecorder!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        configNavigation()
    }
    
    //-------------------------------------//
    // MARK: - LOAD VIEWS
    
    override func loadView()
    {
        view = UIView()
        view.backgroundColor = UIColor.gray
        
        stackView = UIStackView()
        stackView.spacing = 30
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
    }
    
    
    func loadRecordingUI()
    {
        //main thread
        
        //Present recording interface.
    }
    
    
    func loadFailUI()
    {
        //main thread
        
        // The user denies access. Present a message that indicates
        // that they can change their permission settings in the
        // Privacy & Security section of the Settings app.
    }
    
    //-------------------------------------//
    // MARK: - CONFIGURATION
    
    func configNavigation()
    {
        title = "Record your whistle"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Record", style: .plain, target: nil, action: nil)
    }
    
    
    func configRecordingSession() async
    {
        recordingSession = AVAudioSession.sharedInstance()
        // new
        if await AVAudioApplication.requestRecordPermission() {
            
        } else {
            
        }
        
        // old
        do {
            try recordingSession.setCategory(.playAndRecord, mode: .default)
            try recordingSession.setActive(true)
            recordingSession.requestRecordPermission() { [unowned self] allowed in
                DispatchQueue.main.async {
                    if allowed { self.loadRecordingUI() }
                    else { self.loadFailUI() }
                }
            }
        } catch {
            self.loadFailUI()
        }
    }
}
