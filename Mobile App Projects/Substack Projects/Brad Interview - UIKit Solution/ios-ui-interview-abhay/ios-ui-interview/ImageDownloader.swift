//
//  ImageDownloader.swift
//  ios-ui-interview
//
//  Created by Abhay Curam on 12/7/25.
//

import Foundation
import UIKit

public class ImageDownloader {
    
    public func downloadImage(_ imageURL: URL,
                              _ callbackQueue: DispatchQueue,
                              _ completion: @escaping ((UIImage?, Error?) -> Void)) {
        let task = URLSession.shared.dataTask(with: imageURL) { (data, response, error) in
            if error == nil, let imageData = data {
                let image = UIImage(data: imageData)
                let decodedImage = image?.preparingForDisplay()
                callbackQueue.async {
                    completion(decodedImage, nil)
                }
            } else {
                callbackQueue.async {
                    completion(nil, error)
                }
            }
        }
        task.resume()
    }
    
}
