//  File: WWWhistle.swift
//  Project: Project33-WhatsThatWhistle
//  Created by: Noah Pope on 7/15/25.

import UIKit
import CloudKit

class WWWhistle: NSObject
{
    var recordID: CKRecord.ID!
    var genre: String!
    var comments: String!
    var audio: URL!
}
