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
    static let micAccessFail = "Recording failed: please ensure the app has access to your microphone."
    static let recordingFail = "There was a problem recording your whistle; please try again."
    static let playbackFail = "There was a problem playing your whistle; please try re-recording."
    static let fetchFail = "There was a problem fethcing the list of whistles; please try again"
}

enum DirectoryKeys
{
    static let whistle = "Whistle.m4a"
    static let iCloudContainer = "iCloud.com.noahpope.Project33-WhatsThatWhistle"
}

enum PlaceHolderKeys
{
    static let comments = "If you have any additional comments that might help identify your tune, enter them here."
}
