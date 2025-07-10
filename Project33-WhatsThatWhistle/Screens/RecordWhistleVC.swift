//  File: RecordWhistleVC.swift
//  Project: Project33-WhatsThatWhistle
//  Created by: Noah Pope on 6/23/25.

import UIKit
import AVFoundation

enum PlayButtonToggleOptions
{
    case on, off
}

class RecordWhistleVC: UIViewController, AVAudioRecorderDelegate
{
    var stackView: UIStackView!
    var recordButton: UIButton!
    var recordingSession: AVAudioSession!
    var whistleRecorder: AVAudioRecorder!
    var whistlePlayer: AVAudioPlayer!
    var playButton: UIButton!
    
    
    override func loadView() { configUI() }
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        configNavigation()
        configRecordingSession()
    }
    
    //-------------------------------------//
    // MARK: - CONFIGURATION
    
    func configNavigation()
    {
        title = "Record your whistle"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Record", style: .plain, target: nil, action: nil)
    }
    
    
    func configRecordingSession()
    {
        recordingSession = AVAudioSession.sharedInstance()

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
    
    
    func configUI()
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
    
    //-------------------------------------//
    // MARK: - LOADING UIs
    
    func loadRecordingUI()
    {
        recordButton = UIButton()
        recordButton.translatesAutoresizingMaskIntoConstraints = false
        recordButton.setTitle("Tap to Record", for: .normal)
        recordButton.titleLabel?.font = UIFont.preferredFont(forTextStyle: .title1)
        recordButton.addTarget(self, action: #selector(recordTapped), for: .touchUpInside)
        stackView.addArrangedSubview(recordButton)
        
        playButton = UIButton()
        playButton.translatesAutoresizingMaskIntoConstraints = false
        playButton.setTitle("Tap to Play", for: .normal)
        playButton.alpha = 0 // don't show it to the user...
        playButton.isHidden = true // ..and don't take up any space in stack view
        playButton.titleLabel?.font = UIFont.preferredFont(forTextStyle: .title1)
        playButton.addTarget(self, action: #selector(playTapped), for: .touchUpInside)
        stackView.addArrangedSubview(playButton)
    }
    
    
    func loadFailUI()
    {
        let failLabel = UILabel()
        failLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        failLabel.text = MessageKeys.failLabel
        failLabel.numberOfLines = 0
        
        stackView.addArrangedSubview(failLabel)
    }
    
    //-------------------------------------//
    // MARK: - RECORDING THE WHISTLE
    
    @objc func recordTapped()
    {
        if whistleRecorder == nil {
            startRecording()
            togglePlayButton(.off)
        } else {
            finishRecording(success: true)
        }
    }
    
    
    class func getWhistleURL() -> URL
    { return getDocumentsDirectory().appendingPathComponent(DirectoryKeys.whistle) }
    
    
    class func getDocumentsDirectory() -> URL
    {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        // use Finder to go to what's printed beneath after recording to ensure file writing works
        print("documentsDirectoryPath = \(documentsDirectory)")
        return documentsDirectory
    }
    
    
    func startRecording()
    {
        view.backgroundColor = UIColor(red: 0.6, green: 0, blue: 0, alpha: 1)
        recordButton.setTitle("Tap to Stop", for: .normal)
        
        let audioURL = RecordWhistleVC.getWhistleURL()
        print(audioURL.absoluteString)
        
        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
        
        do {
            whistleRecorder = try AVAudioRecorder(url: audioURL, settings: settings)
            whistleRecorder.delegate = self
            whistleRecorder.record()
        } catch {
            finishRecording(success: false)
        }
    }
    
    
    func finishRecording(success: Bool)
    {
        view.backgroundColor = UIColor(red: 0, green: 0.6, blue: 0, alpha: 1)
        whistleRecorder.stop()
        whistleRecorder = nil
        
        if success {
            recordButton.setTitle("Tap to Re-record", for: .normal)
            togglePlayButton(.on)
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(nextTapped))
        } else {
            recordButton.setTitle("Tap to Record", for: .normal)
            let ac = UIAlertController(title: "Recording failed", message: MessageKeys.recordingFail, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        }
    }
    
    
    func togglePlayButton(_ flag: PlayButtonToggleOptions)
    {
        UIView.animate(withDuration: 0.35) { [unowned self] in
            self.playButton.isHidden = flag == .on ? false : true
            self.playButton.alpha = flag == .on ? 1 : 0
        }
    }
    
    //-------------------------------------//
    // MARK: - PLAYBACK & ADVANCING
    
    @objc func playTapped()
    {
        let audioURL = RecordWhistleVC.getWhistleURL()
        
        do {
            whistlePlayer = try AVAudioPlayer(contentsOf: audioURL)
            whistlePlayer.play()
        } catch {
            let ac = UIAlertController(title: "Playback failed", message: MessageKeys.playbackFail, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        }
    }
    
    
    @objc func nextTapped()
    {
        let vc = SelectGenreTableVC()
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    //-------------------------------------//
    // MARK: -
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool)
    {
        if !flag { finishRecording(success: false) }
    }
}
