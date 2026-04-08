//
//  AudioRecordingSession.swift
//  SimpleAudioRecorder
//
//  Created by Abhay Curam on 11/18/25.
//

import AVFoundation

public protocol AudioRecorder {
    var isRecording: Bool { get }
    func startRecording() -> Bool
    func stopRecording() -> Bool
}

public enum AudioRecordingAuthorizationStatus {
    case userGranted, userDenied, unknown
}

public protocol AudioRecorderAuthorization {
    func requestRecordingAuthorization(completion: @escaping ((AudioRecordingAuthorizationStatus) -> Void))
}

public protocol AudioRecordingSessionDelegate: AnyObject {
    func audioRecordingSessionFinishedSuccessfully(_ assetURL: URL)
    func audioRecordingSessionFinishedWithError(_ assetURL: URL, error: Error?)
}

public protocol AudioRecordingSessionProtocol: AudioRecorder, AudioRecorderAuthorization {
    var delegate: AudioRecordingSessionDelegate? { get set }
}

public class AudioRecordingSession: NSObject, AudioRecordingSessionProtocol, AVAudioRecorderDelegate {

    public var isRecording: Bool {
        if let recorder = audioRecorder {
            return recorder.isRecording
        }
        return false
    }
    
    public weak var delegate: AudioRecordingSessionDelegate?
    
    private let storageLocation: AudioRecordingStorageLocation
    private let audioAssetFormat: AudioAssetFormat
    private lazy var audioRecorder: AVAudioRecorder? = {
        do {
            let recorder = try AVAudioRecorder(url: storageLocation.audioAssetURI,
                                               settings: audioAssetFormat.audioSettingsDictionary())
            recorder.delegate = self
            return recorder
        } catch {
            return nil
        }
    }()
    
    public init(_ storageLocation: AudioRecordingStorageLocation,
                _ audioAssetFormat: AudioAssetFormat)
    {
        self.storageLocation = storageLocation
        self.audioAssetFormat = audioAssetFormat
    }
    
    public func startRecording() -> Bool {
        guard let currentAudioRecorder = audioRecorder else { return false }
        do {
            try setupAVAudioSession()
            currentAudioRecorder.prepareToRecord()
            currentAudioRecorder.record()
            return true
        } catch {
            return false
        }
    }
    
    public func stopRecording() -> Bool {
        guard let currentAudioRecorder = audioRecorder else { return false }
        do {
            currentAudioRecorder.stop()
            try tearDownAVAudioSession()
            return true
        } catch {
            return false
        }
    }
    
    public func requestRecordingAuthorization(completion: @escaping ((AudioRecordingAuthorizationStatus) -> Void)) {
        let permission = AVAudioApplication.shared.recordPermission
        switch permission {
        case .undetermined:
            AVAudioApplication.requestRecordPermission { didGrant in
                let status: AudioRecordingAuthorizationStatus = didGrant ? .userGranted : .userDenied
                completion(status)
            }
        case .denied:
            completion(.userDenied)
        case .granted:
            completion(.userGranted)
        @unknown default:
            completion(.unknown)
        }
    }
    
    public func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag {
            delegate?.audioRecordingSessionFinishedSuccessfully(storageLocation.audioAssetURI)
        } else {
            delegate?.audioRecordingSessionFinishedWithError(storageLocation.audioAssetURI, error: nil)
        }
    }
    
    public func audioRecorderEncodeErrorDidOccur(_ recorder: AVAudioRecorder, error: (any Error)?) {
        //This is likely not the correct way to handle.
        delegate?.audioRecordingSessionFinishedWithError(storageLocation.audioAssetURI, error: error)
    }
    
    private func setupAVAudioSession() throws(Error) {
        do {
            let avAudioSession = AVAudioSession.sharedInstance()
            try avAudioSession.setCategory(.playAndRecord, mode: .default)
            try avAudioSession.setActive(true, options: .notifyOthersOnDeactivation)
        } catch {
            throw error
        }
    }
    
    private func tearDownAVAudioSession() throws(Error) {
        do {
            let avAudioSession = AVAudioSession.sharedInstance()
            try avAudioSession.setActive(false, options: .notifyOthersOnDeactivation)
        } catch {
            throw error
        }
    }
}
