//  File: UIAlertController+Ext.swift
//  Project: Project33-WhatsThatWhistle
//  Created by: Noah Pope on 6/23/25.

import UIKit
extension UIAlertController
{
    func addActions(_ actions: UIAlertAction...)
    { for action in actions { self.addAction(action) } }
}
