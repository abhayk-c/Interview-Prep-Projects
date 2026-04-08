//
//  AudioRecordingNoteView.swift
//  SimpleAudioRecorderApp
//
//  Created by Abhay Curam on 11/19/25.
//

import UIKit

/*
 * A simple container view for starting and stopping audio recording
 * with an explicit createNote transcription
 */


public protocol AudioRecordingNoteViewDelegate {
    
    func recordButtonTappedRecordingDidStart()
    
    func recordButtonTappedRecordingPaused()
    
    func recordButtonTappedRecordingResumed()
    
    func createNoteButtonTappedRecordingFinished()
    
}

public class AudioRecordingNoteView: UIView {
    
    private enum RecordingState {
        case recordingNotStarted
        case recording
        case pausedRecording
    }
    
    private struct Constants {
        static let startRecordingText = "Start Recording"
        static let nowRecordingText = "Now Recording"
        static let tapToResumeRecording = "Tap to resume recording"
        
        static let recordButtonRecordText = "Record"
        static let recordButtonPauseText = "Pause"
        static let recordButtonResumeText = "Resume"
        static let createNoteText = "Create Note"
        
        static let buttonSize = CGSize(width: 113, height: 44)
        static let recordingStatusLabelSize = CGSize(width: 200, height: 44)
    }
    
    private lazy var recordingStatusLabel: UILabel = {
        let recordingStatusLabel = UILabel(frame: .zero)
        recordingStatusLabel.text = Constants.startRecordingText
        recordingStatusLabel.textAlignment = .center
        recordingStatusLabel.numberOfLines = 1
        let font = UIFont.systemFont(ofSize: 14)
        recordingStatusLabel.font = font
        recordingStatusLabel.textColor = UIColor.black
        return recordingStatusLabel
    }()
    
    
    private lazy var recordButton: UIButton = {
        let recordButton = UIButton(type: .system)
        recordButton.setTitle(Constants.recordButtonRecordText, for: .normal)
        recordButton.setTitle(Constants.recordButtonRecordText, for: .disabled)
        recordButton.backgroundColor = UIColor.systemRed
        recordButton.setTitleColor(UIColor.white, for: .normal)
        recordButton.setTitleColor(UIColor.white, for: .disabled)
        recordButton.addTarget(self, action: #selector(recordButtonTapped), for: .touchUpInside)
        return recordButton
    }()
    
    private lazy var createNoteButton: UIButton = {
        let createNoteButton = UIButton(type: .system)
        createNoteButton.setTitle(Constants.createNoteText, for: .normal)
        createNoteButton.setTitle(Constants.createNoteText, for: .disabled)
        createNoteButton.backgroundColor = UIColor.black
        createNoteButton.setTitleColor(UIColor.white, for: .normal)
        createNoteButton.setTitleColor(UIColor.white, for: .disabled)
        createNoteButton.addTarget(self, action: #selector(createNoteButtonTapped), for: .touchUpInside)
        return createNoteButton
    }()
    
    private var recordingState: RecordingState
    
    private var delegate: AudioRecordingNoteViewDelegate?
    
    public override init(frame: CGRect) {
        recordingState = .recordingNotStarted
        super.init(frame: frame)
        addSubview(recordingStatusLabel)
        addSubview(recordButton)
        addSubview(createNoteButton)
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        let recordingStatusLabelOriginX: CGFloat = (bounds.width / 2) - (Constants.recordingStatusLabelSize.width / 2)
        let recordingStatusLabelOriginY: CGFloat = (bounds.height / 2) - (Constants.recordingStatusLabelSize.height / 2)
        recordingStatusLabel.frame = CGRect(origin: CGPoint(x: recordingStatusLabelOriginX, y: recordingStatusLabelOriginY), size: Constants.recordingStatusLabelSize)
        
        let recordButtonOriginX: CGFloat = (bounds.width / 2) - (Constants.buttonSize.width / 2)
        let recordButtonOriginY: CGFloat = recordingStatusLabelOriginY + Constants.recordingStatusLabelSize.height + 30
        recordButton.frame = CGRect(origin: CGPoint(x: recordButtonOriginX, y: recordButtonOriginY), size: Constants.buttonSize)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func recordButtonTapped(_ sender: UIButton) {
        switch recordingState {
        case .recordingNotStarted:
            recordingStatusLabel.text = Constants.nowRecordingText
            recordButton.setTitle(Constants.recordButtonPauseText, for: .normal)
            recordButton.setTitle(Constants.recordButtonPauseText, for: .disabled)
        case .recording:
            <#code#>
        case .pausedRecording:
            <#code#>
        }
    }
    
    @objc private func createNoteButtonTapped(_ sender: UIButton) {
        print("record button tapped")
    }
    
}
