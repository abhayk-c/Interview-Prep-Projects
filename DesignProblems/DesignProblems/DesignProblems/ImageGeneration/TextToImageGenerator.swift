//
//  TextToImageGenerator.swift
//  DesignProblems
//
//  Created by Abhay Curam on 11/9/25.
//

import Foundation
import Photos

public struct TextToImageGenerationRequest {
    let requestID: String
    let textPrompt: String
    let textEmbeddings: [NSNumber]
}

/**
 * This could have also been a full fledged class with a cancellation API,
 * think NSOperation. But for the current scope of the problem this felt enough.
 * Main thing is to just talk this through in an interview.
 */
public struct TextToImageGenerationOperation {
    let request: TextToImageGenerationRequest //could also just be requestID
    let operationID: String
    let imageGenerationCount: Int
}

public protocol TextToImageGenerationDelegate {
    func imageGeneratorDidGenerateImage(_ imageAsset: PHAsset,
                                        _ imageAssetURI: URL,
                                        _ imageIndex: Int,
                                        _ job: TextToImageGenerationOperation)
}

/**
 * The API is very simple:
 *
 * 1. Client calls createTextToImageGenerationRequest() to create a gen image AI request. The API is
 *    async because if server based will likely require HTTP POST, if on-device may require prompt analysis (text embeddings)
 *
 * 2. Client calls generateImages() and specifies a number of images to generate and the TextToImageGenerationRequest
 *    returned in step 1. A Operation object is returned for the image-gen request and images are returned in real-time
 *    over the delegate.
 *
 * 3. Client calls deleteTextToImageGenerationRequest to explicitly delete a image-gen request.
 *    If server-based this will end the image-request (generation session) via HTTP Post and clean up the downloaded
 *    images from disk in both scenarios. May do some pipeline clean up if on-device.
 *
 */
public protocol TextToImageGeneration {
    var delegate: TextToImageGenerationDelegate { get set }
    
    typealias ImageGenCreateCompletion = ((_ request: TextToImageGenerationRequest?, _ error: NSError?) -> Void)
    typealias ImageGenDeleteCompletion = ((_ success: Bool, _ error: NSError?) -> Void)
    typealias ImageGenJobCompletion = ((_ job: TextToImageGenerationOperation?, _ error: NSError?) -> Void)
    
    func createTextToImageGenerationRequest(_ textPrompt: String, _ completion: @escaping ImageGenCreateCompletion)
    func generateImages(_ count: Int, for request: TextToImageGenerationRequest, _ completion: ImageGenJobCompletion)
    func deleteTextToImageGenerationRequest(_ request: TextToImageGenerationRequest, _ completion: @escaping ImageGenDeleteCompletion)
}

public class TextToImageGenerator: TextToImageGeneration {
    public var delegate: any TextToImageGenerationDelegate
    public func createTextToImageGenerationRequest(_ textPrompt: String, _ completion: @escaping ImageGenCreateCompletion) {}
    public func generateImages(_ count: Int, for request: TextToImageGenerationRequest, _ completion: (TextToImageGenerationOperation?, NSError?) -> Void) {}
    public func deleteTextToImageGenerationRequest(_ request: TextToImageGenerationRequest, _ completion: @escaping ImageGenDeleteCompletion) {}
}
