//
//  SiriDictation.swift
//  DesignProblems
//
//  Created by Abhay Curam on 11/5/25.
//

import Foundation

public typealias SessionCompletion = ((Bool, Error?) -> Void)
public protocol SiriDictationAudioCaptureSessionManager {
    func startAudioCaptureSession(_ callbackQueue: DispatchQueue, _ completion: SessionCompletion)
    func stopAudioCaptureSession(_ completion: SessionCompletion)
}

public protocol SiriDictationTokenStreamDelegate {
    func siriDictationDidRecieveNewTokens(_ tokens: [String])
}

/*
 * Very simple API interface, client.
 * Start real-time dictation tokenization collection, and stop.
 * The client has no idea about the session management and inference
 * pipeline under the hood. Clients get real time processed words
 * via the SiriDictationStreamDelegate
 */
public class SiriDictationRealTimeTokenizer {
    
    public init(_ tokenDelegate: SiriDictationTokenStreamDelegate,
                _ audioSessionManager: SiriDictationAudioCaptureSessionManager) {}
    
    public func startRealTimeDictationTokenization(_ callbackQueue: DispatchQueue) -> Void {}
    
    public func stopRealTimeDictationTokenization() -> Void {}
    
}

/**
 * Clients will use a factory to create the real time tokenizer.
 * Simplifies creation of the Tokenizer for the client because we will
 * inject all dependencies via the constructor to enable high amount of
 * extensibility to swap different implementations of the core.
 */
public struct SiriDictationRealTimeTokenizerFactory {
    
    public static func createDefaultRealTimeTokenizer() -> SiriDictationRealTimeTokenizer? {}
    
}
