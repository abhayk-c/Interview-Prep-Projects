//
//  MediaAttachment.swift
//  NotionDocumentStore
//
//  Created by Abhay Curam on 10/5/25.
//

import Foundation

public protocol MediaAttachment {
    var assetURI: URL { get }
    var mediaFormat: String { get }
    var createdDate: Date { get }
    var lastModified: Date { get }
}

public struct ImageMediaAttachment: MediaAttachment {
    public private(set) var assetURI: URL
    public private(set) var mediaFormat: String
    public private(set) var createdDate: Date
    public private(set) var lastModified: Date
    public private(set) var imageSize: CGSize
}

public struct VideoMediaAttachment: MediaAttachment {
    public private(set) var assetURI: URL
    public private(set) var mediaFormat: String
    public private(set) var createdDate: Date
    public private(set) var lastModified: Date
    public private(set) var length: TimeInterval
}

public struct AudioMediaAttachment: MediaAttachment {
    public private(set) var assetURI: URL
    public private(set) var mediaFormat: String
    public private(set) var createdDate: Date
    public private(set) var lastModified: Date
    public private(set) var length: TimeInterval
}

