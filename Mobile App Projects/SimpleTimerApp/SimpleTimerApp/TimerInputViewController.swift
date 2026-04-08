//
//  ViewController.swift
//  SimpleTimerApp
//
//  Created by Abhay Curam on 12/12/25.
//

import UIKit

class TimerInputViewController: UIViewController {
    
    private struct Constants {
        static let timerInputTextFieldFont = UIFont.systemFont(ofSize: 24)
        static let timerLabelFont = UIFont.systemFont(ofSize: 34, weight: .bold)
        static let timerStartButtonTitle = "Start"
        static let visualStateUrl = URL.documentsDirectory.appending(path: "timer_data.json")
    }
    
    fileprivate struct TimerData: Codable {
        let scheduledTimeInterval: CFTimeInterval
        let timerStart: CFTimeInterval
    }
    
    private lazy var stackContentView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 40
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var timerInputTextField: UITextField = {
        let textField = UITextField(frame: .zero)
        textField.font = Constants.timerInputTextFieldFont
        textField.textColor = UIColor.black
        textField.textAlignment = .center
        textField.addTarget(self, action: #selector(timerInputTextFieldDidChange), for: .editingChanged)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = UIColor.white
        return textField
    }()
    
    private lazy var startTimerButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.systemOrange
        button.setTitle(Constants.timerStartButtonTitle, for: .normal)
        button.setTitle(Constants.timerStartButtonTitle, for: .disabled)
        button.setTitleColor(UIColor.white, for: .normal)
        button.setTitleColor(UIColor.white, for: .disabled)
        button.addTarget(self, action: #selector(timerStartButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 20
        button.isEnabled = false
        return button
    }()
    
    private lazy var timerLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = Constants.timerLabelFont
        label.numberOfLines = 1
        label.textAlignment = .center
        label.lineBreakMode = .byTruncatingTail
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "00:00"
        label.textColor = UIColor.white
        return label
    }()
    
    private var repeatingTimer = Timer()
    private var currentTimerData = TimerData(scheduledTimeInterval: 0, timerStart: 0)
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    public init() {
        super.init(nibName: nil, bundle: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(handleWillDeactivateNotification),
                                               name: UIScene.willDeactivateNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(handleDidActivateNotification),
                                               name: UIScene.didActivateNotification,
                                               object: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black
        stackContentView.addArrangedSubview(timerInputTextField)
        stackContentView.addArrangedSubview(startTimerButton)
        stackContentView.addArrangedSubview(timerLabel)
        view.addSubview(stackContentView)
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            stackContentView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            stackContentView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackContentView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            timerInputTextField.widthAnchor.constraint(equalTo: stackContentView.widthAnchor, multiplier: 0.6),
            startTimerButton.widthAnchor.constraint(equalToConstant: 80),
            startTimerButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    @objc private func timerInputTextFieldDidChange() {
        if let inputText = timerInputTextField.text, let _ = Double(inputText) {
            startTimerButton.isEnabled = true
        }
    }
    
    @objc private func timerStartButtonTapped() {
        if let inputText = timerInputTextField.text, let inputTimeInterval = Double(inputText) {
            scheduleRepeatingTimer(inputTimeInterval, CACurrentMediaTime())
        }
    }
    
    @objc private func handleDidActivateNotification() {
        do {
            let path = Constants.visualStateUrl.path
            if let data = FileManager.default.contents(atPath: Constants.visualStateUrl.path) {
                let timerData = try JSONDecoder().decode(TimerData.self, from: data)
                scheduleRepeatingTimer(timerData.scheduledTimeInterval, timerData.timerStart)
            }
        } catch {
            //no op
        }
    }
    
    @objc private func handleWillDeactivateNotification() {
        repeatingTimer.invalidate()
    }
    
    private func getElapsedTimeFormattedText(_ elapsedTime: CFTimeInterval) -> String {
        var minutes: Int = 0
        var seconds: Int = Int(elapsedTime)
        if elapsedTime >= 60 {
            minutes = Int(elapsedTime) / 60
        }
        if elapsedTime > 0 {
            seconds = Int(elapsedTime) % 60
        }
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    private func scheduleRepeatingTimer(_ scheduledInterval: TimeInterval,
                                        _ timerStart: TimeInterval) {
        startTimerButton.isEnabled = false
        timerInputTextField.isEnabled = false
        setTimerData(scheduledInterval, timerStart)
        repeatingTimer = Timer.scheduledTimer(withTimeInterval: 0.25, repeats: true, block: { [weak self] timer in
            guard let strongSelf = self else { return }
            let elapsedTime = floor(CACurrentMediaTime() - strongSelf.currentTimerData.timerStart)
            strongSelf.timerLabel.text = strongSelf.getElapsedTimeFormattedText(elapsedTime)
            if elapsedTime >= strongSelf.currentTimerData.scheduledTimeInterval {
                strongSelf.startTimerButton.isEnabled = true
                strongSelf.timerInputTextField.isEnabled = true
                timer.invalidate()
                strongSelf.resetTimerData()
            }
        })
    }
    
    private func setTimerData(_ scheduledTimeInterval: CFTimeInterval,
                              _ timerStart: CFTimeInterval)
    {
        currentTimerData = TimerData(scheduledTimeInterval: scheduledTimeInterval, timerStart: timerStart)
        do {
            let serializedTimerData = try JSONEncoder().encode(currentTimerData)
            try serializedTimerData.write(to: Constants.visualStateUrl)
        } catch {
            //no op
        }
    }

    private func resetTimerData()
    {
        currentTimerData = TimerData(scheduledTimeInterval: 0, timerStart: 0)
        do {
            try FileManager.default.removeItem(atPath: Constants.visualStateUrl.path)
        } catch {
            //no op
        }
    }

}

