//  File: AVPlayer+Ext.swift
//  Project: Project33-WhatsThatWhistle
//  Created by: Noah Pope on 6/23/25.

import Foundation
import AVKit
import AVFoundation

extension AVPlayer
{
    var isPlaying: Bool { return rate != 0 && error == nil }
}
