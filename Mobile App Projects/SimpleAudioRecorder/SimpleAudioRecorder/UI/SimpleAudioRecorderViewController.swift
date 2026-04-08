//
//  SimpleAudioRecorderViewController.swift
//  SimpleAudioRecorder
//
//  Created by Abhay Curam on 11/18/25.
//

import UIKit
import AVFoundation

public class SimpleAudioRecorderViewController: UIViewController, AudioRecordingSessionDelegate {

    private struct Constants {
        static let buttonCornerRadius: CGFloat = 22
        static let recordButtonTitleText = "Record"
        static let stopButtonTitleText = "Stop"
        static let playButtonTitleText = "Play"
        static let buttonSize = CGSize(width: 113, height: 44)
        static let buttonYRatio: CGFloat = 0.25469
        static let interButtonSpacing: CGFloat = 30
    }
    
    private lazy var recordButton: UIButton = {
        let recordButton = UIButton(type: .system)
        recordButton.backgroundColor = UIColor.systemRed
        recordButton.layer.cornerRadius = Constants.buttonCornerRadius
        recordButton.titleLabel?.font = UIFont.systemFont(ofSize: 22, weight: .regular)
        recordButton.setTitleColor(UIColor.white, for: .normal)
        recordButton.setTitleColor(UIColor.darkGray, for: .disabled)
        recordButton.setTitle(Constants.recordButtonTitleText, for: .normal)
        recordButton.setTitle(Constants.recordButtonTitleText, for: .disabled)
        recordButton.addTarget(self, action: #selector(recordButtonTapped(_:)), for: .touchUpInside)
        return recordButton
    }()
    
    private lazy var playButton: UIButton = {
        let playButton = UIButton(type: .system)
        playButton.backgroundColor = UIColor.systemGreen
        playButton.layer.cornerRadius = Constants.buttonCornerRadius
        playButton.titleLabel?.font = UIFont.systemFont(ofSize: 22, weight: .regular)
        playButton.setTitleColor(UIColor.white, for: .normal)
        playButton.setTitleColor(UIColor.darkGray, for: .disabled)
        playButton.setTitle(Constants.playButtonTitleText, for: .normal)
        playButton.setTitle(Constants.playButtonTitleText, for: .disabled)
        playButton.addTarget(self, action: #selector(playButtonTapped(_:)), for: .touchUpInside)
        return playButton
    }()
    
    private var audioRecordingSession: AudioRecordingSessionProtocol
    
    /**
     * Wrapping in its own object could be a cleaner design because looks
     * like before audio playback its better to setup and start the AVSession.
     * Because we aren't doing that the volume sounds low (coming out of the wrong microphone).
     */
    private var audioPlayer: AVAudioPlayer?
    
    public init(_ audioRecordingSession: AudioRecordingSessionProtocol) {
        self.audioRecordingSession = audioRecordingSession
        super.init(nibName: nil, bundle: nil)
        self.audioRecordingSession.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black
        recordButton.isEnabled = true
        playButton.isEnabled = false
        view.addSubview(recordButton)
        view.addSubview(playButton)
    }
    
    public override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        let originX = (view.bounds.width / 2) - (Constants.buttonSize.width / 2)
        let recordButtonOriginY = view.bounds.height * Constants.buttonYRatio
        recordButton.frame = CGRect(origin: CGPoint(x: originX, y: recordButtonOriginY),
                                    size: Constants.buttonSize)
        let playButtonOriginY = recordButtonOriginY + Constants.buttonSize.height + Constants.interButtonSpacing
        playButton.frame = CGRect(origin: CGPoint(x: originX, y: playButtonOriginY),
                                  size: Constants.buttonSize)
    }
    
    public func audioRecordingSessionFinishedSuccessfully(_ assetURL: URL) {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: assetURL)
            audioPlayer?.prepareToPlay()
        } catch {}
    }
    
    public func audioRecordingSessionFinishedWithError(_ assetURL: URL, error: (any Error)?) {
        //no op
    }
    
    @objc private func recordButtonTapped(_ sender: UIButton) {
        if audioRecordingSession.isRecording {
            if audioRecordingSession.stopRecording() == true {
                recordButton.setTitle(Constants.recordButtonTitleText, for: .normal)
                recordButton.setTitle(Constants.recordButtonTitleText, for: .disabled)
                playButton.isEnabled = true
            }
        } else {
            audioRecordingSession.requestRecordingAuthorization { [weak self] authorizationStatus in
                if let strongSelf = self, authorizationStatus == .userGranted {
                    if strongSelf.audioRecordingSession.startRecording() == true {
                        strongSelf.recordButton.setTitle(Constants.stopButtonTitleText, for: .normal)
                        strongSelf.recordButton.setTitle(Constants.stopButtonTitleText, for: .disabled)
                        strongSelf.playButton.isEnabled = false
                    }
                }
            }
        }
    }
    
    @objc private func playButtonTapped(_ sender: UIButton) {
        if let currentAudioPlayer = audioPlayer {
            if !currentAudioPlayer.isPlaying {
                currentAudioPlayer.play()
            }
        }
    }

}

