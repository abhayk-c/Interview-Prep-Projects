//
//  MediaBlocks.swift
//  NotionDocumentStore
//
//  Created by Abhay Curam on 10/5/25.
//

public class ImageMediaBlock: Block {
    public private(set) var blockID: String
    public var imageAsset: ImageMediaAttachment
    public init(imageAsset: ImageMediaAttachment, blockID: String) {
        self.blockID = blockID
        self.imageAsset = imageAsset
    }
}

public class VideoMediaBlock: Block {
    public private(set) var blockID: String
    public var videoAsset: VideoMediaAttachment
    public init(videoAsset: VideoMediaAttachment, blockID: String) {
        self.blockID = blockID
        self.videoAsset = videoAsset
    }
}

public class AudioMediaBlock: Block {
    public private(set) var blockID: String
    public var audioAsset: AudioMediaAttachment
    public init(audioAsset: AudioMediaAttachment, blockID: String) {
        self.blockID = blockID
        self.audioAsset = audioAsset
    }
}
