//
//  AudioRecordingStorageLocation.swift
//  SimpleAudioRecorder
//
//  Created by Abhay Curam on 11/18/25.
//

import Foundation

public struct AudioRecordingStorageLocation {
    let storageDirectory: URL
    let audioAssetURI: URL
    public init() {
        let storagePaths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        self.storageDirectory = storagePaths[0]
        let assetFileName: String = UUID().uuidString + ".mp4"
        self.audioAssetURI = self.storageDirectory.appendingPathComponent(assetFileName)
    }
}
