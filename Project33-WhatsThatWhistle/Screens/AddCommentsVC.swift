//  File: AddCommentsVC.swift
//  Project: Project33-WhatsThatWhistle
//  Created by: Noah Pope on 7/9/25.

import UIKit

class AddCommentsVC: UIViewController, UITextViewDelegate
{
    var genre: String!
    var comments: UITextView!
    var placeHolder = PlaceHolderKeys.comments
    
    override func loadView()
    {
        configUI()
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        configNavigation()
        configTextView()
    }
    
    //-------------------------------------//
    // MARK: - CONFIGURATION
    
    func configUI()
    {
        #warning("why do I need to mmake an instance of UIView() when I can access 'view' without it? ~ pg 1187")
        view = UIView()
        view.backgroundColor = .white
        
        comments = UITextView()
        comments.translatesAutoresizingMaskIntoConstraints = false
        comments.delegate = self
        comments.font = UIFont.preferredFont(forTextStyle: .body)
        view.addSubview(comments)
        
        NSLayoutConstraint.activate([
            comments.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            comments.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            comments.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            comments.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    
    func configNavigation()
    {
        title = "Comments"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Submit", style: .plain, target: self, action: #selector(submitTapped))
    }
    
    
    func configTextView() { comments.text = placeHolder }
    
    //-------------------------------------//
    // MARK: - SUBMISSION
    
    @objc func submitTapped()
    {
        let vc = SubmitVC()
        vc.genre = genre
        
        if comments.text == placeHolder {
            vc.comments = ""
        } else {
            vc.comments = comments.text
        }
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    //-------------------------------------//
    // MARK: - TEXT VIEW DELEGATE METHODS
    
    func textViewDidBeginEditing(_ textView: UITextView)
    {
        if textView.text == placeHolder {
            textView.text = ""
        }
    }
}
