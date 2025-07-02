//  File: Constants+Utils.swift
//  Project: Project33-WhatsThatWhistle
//  Created by: Noah Pope on 6/23/25.

import Foundation

enum PersistenceKeys
{
    static let isFirstVisitAfterDismissal = "isFirstVisitAfterDismissal"
}

enum VideoKeys
{
    static let launchScreen = "launchscreen"
    static let playerLayerName = "PlayerLayerName"
}

enum MessageKeys
{
    static let failLabel = "Recording failed: please ensure the app has access to your microphone."
    static let recordingFailed = "There was a problem recording your whistle; please try again."
}

enum DirectoryKeys
{
    static let whistle = "Whistle.m4a"
}
