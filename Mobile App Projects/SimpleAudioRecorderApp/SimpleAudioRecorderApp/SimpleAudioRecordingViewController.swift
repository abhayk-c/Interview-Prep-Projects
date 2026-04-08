//
//  ViewController.swift
//  SimpleAudioRecorderApp
//
//  Created by Abhay Curam on 11/19/25.
//

import UIKit

public class SimpleAudioRecordingViewController: UIViewController {

    private struct Constants {
        static let recordingNoteHeightRatio: CGFloat = 0.5
        static let recordingNoteLeftRightPadding: CGFloat = 20
    }
    
    private lazy var recordingNoteView: AudioRecordingNoteView = {
        let recordingView = AudioRecordingNoteView()
        return recordingView
    }()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        view.addSubview(recordingNoteView)
    }
    
    public init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    public override func viewWillLayoutSubviews() {
        let recordingNoteViewHeight = view.bounds.height * Constants.recordingNoteHeightRatio
        let recordingNoteViewWidth = view.bounds.width - (Constants.recordingNoteLeftRightPadding * 2)
        let recordingNoteOriginX = (view.bounds.width / 2) - (recordingNoteViewWidth / 2)
        let recordingNoteOriginY = (view.bounds.height / 2) - (recordingNoteViewHeight / 2)
        recordingNoteView.frame = CGRect(origin: CGPoint(x: recordingNoteOriginX, y: recordingNoteOriginY), size: CGSize(width: recordingNoteViewWidth, height: recordingNoteViewHeight))
    }

}

