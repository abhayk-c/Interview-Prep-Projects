//
//  AudioAssetFormat.swift
//  SimpleAudioRecorder
//
//  Created by Abhay Curam on 11/18/25.
//

import Foundation
import AVFoundation

public enum AudioAssetFormat {
    case mp4
    
    public func audioSettingsDictionary() -> [String : Any] {
        switch self {
        case .mp4:
            return [
                AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
                AVSampleRateKey: 12000,
                AVNumberOfChannelsKey: 1,
                AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
            ]
        }
        return [:]
    }
}
