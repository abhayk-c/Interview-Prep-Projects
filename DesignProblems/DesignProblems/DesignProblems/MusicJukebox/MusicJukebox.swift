//
//  MusicJukebox.swift
//  DesignProblems
//
//  Created by Abhay Curam on 11/16/25.
//

import Foundation

public enum AssetMediaType {
    case mp4, mp3, wav, mov, itunes
}

public struct AudioAsset {
    public let assetURI: URL
    public let assetLength: TimeInterval
    public let assetMediaType: AssetMediaType
}

public struct Artist {
    public let name: String
    public let publisher: String
    public let artistID: String
}

public enum MusicGenre {
    case rock, hiphop, country, jazz, blues, reggaeton, classical
}

public struct Song {
    public let songID: String
    public let audioAsset: AudioAsset
    public let numCredits: Int
    public let songTitle: String
    public let artist: Artist
    public let albumArtURIString: String?
    public let genre: MusicGenre
}

public struct Credit {
    public let price: NSNumber
}

/**
 * Could essentially morph into a UserSession object down the line.
 */
public class User {
    public let userName: String
    public let userID: String
    public let firstName: String
    public let lastName: String
    public var numCurrentCredits: Int
    public init(userName: String, userID: String, firstName: String, lastName: String, numCurrentCredits: Int) {
        self.userName = userName
        self.userID = userID
        self.firstName = firstName
        self.lastName = lastName
        self.numCurrentCredits = numCurrentCredits
    }
}


public enum AddSongResult {
    case songAddedAndPlaying
    case songAddedAndQueued(position: Int)
}

public protocol AudioPlayback {
    func startPlaybackSession(_ audioAsset: AudioAsset) async throws(Error) -> Bool
    func stopPlaybackSession() async throws(Error) -> Bool
    func pausePlayback() async throws(Error) -> Bool
    func resumePlayback() async throws(Error) -> Bool
}

public struct AVCaptureDeviceOutput {}

/**
 * This guy would have a delegate to communicate timestamps and progress of
 * playback for a current song so far. Think back to our VideoProgressAnnouncer.
 */
public class AudioPlaybackSession: AudioPlayback {
    
    private let deviceOutput: AVCaptureDeviceOutput
    
    public init(_ deviceOutput: AVCaptureDeviceOutput) {
        self.deviceOutput = deviceOutput
    }
    
    public func startPlaybackSession(_ audioAsset: AudioAsset) async throws(any Error) -> Bool {
        return true
    }
    
    public func stopPlaybackSession() async throws(any Error) -> Bool {
        return true
    }
    
    public func pausePlayback() async throws(any Error) -> Bool {
        return true
    }
    
    public func resumePlayback() async throws(any Error) -> Bool {
        return true
    }
}

public protocol MusicJukeboxPlaying {
    func addSong(_ song: Song) async throws(Error) -> AddSongResult
    func pauseCurrentSong() async throws(Error) -> Bool
    func resumeCurrentSong() async throws(Error) -> Bool
    func skipCurrentSong() async throws(Error) -> Bool
}

public class MusicJukeboxPlayer: MusicJukeboxPlaying {
    
    public var isSongCurrentyPlaying: Bool {
        return false
    }
    
    public var currentSong: Song? {
        return songQueue.first
    }
    
    public var currentPlaylist: [Song] {
        return songQueue
    }
    
    private var songQueue: [Song]
    private var audioPlaybackSession: AudioPlaybackSession
    private let currentUser: User
    
    public init(_ user: User) {
        self.currentUser = user
        self.audioPlaybackSession = AudioPlaybackSession(AVCaptureDeviceOutput())
        self.songQueue = []
    }
    
    public func addSong(_ song: Song) async throws(any Error) -> AddSongResult {
        return .songAddedAndPlaying
    }
    
    public func pauseCurrentSong() async throws(any Error) -> Bool {
        return true
    }
    
    public func resumeCurrentSong() async throws(any Error) -> Bool {
        return true
    }
    
    public func skipCurrentSong() async throws(any Error) -> Bool {
        return true
    }
    
}

/**
 * In a very trivial sense, think of this as a Dictionary mapping lists of songs
 * to recommendation categories (trending, recent, your likes, etc.)
 * As a full fledged struct/object way cleaner though.
 */
public struct SongRecommendations {}

public protocol MusicJukeboxSongProviding {
    func getSongsForTitle(_ songTitle: String) async throws(Error) -> [Song]
    func getSongsForMusicGenre(_ musicGenre: MusicGenre) async throws(Error) -> [Song]
    func getRecommendedSongs() async throws(Error) -> [SongRecommendations]
    
    //we would probably want an API for Albums and require an
    //Album object
    func getSongsForArtist(_ artist: Artist) async throws(Error) -> [Song]
}

/**
 * This would need to coordinate with a DB and a web-service more than likely.
 * But to the user it just feels like they are working with a Library facade.
 */
public class MusicJukeboxSongLibrary: MusicJukeboxSongProviding {
    
    public func getSongsForTitle(_ songTitle: String) async throws(any Error) -> [Song] {
        return []
    }
    
    public func getSongsForMusicGenre(_ musicGenre: MusicGenre) async throws(any Error) -> [Song] {
        return []
    }
    
    public func getRecommendedSongs() async throws(any Error) -> [SongRecommendations] {
        return []
    }
    
    public func getSongsForArtist(_ artist: Artist) async throws(any Error) -> [Song] {
        return []
    }
}
