//
//  StarWarsCharacterDetailViewController.swift
//  MicrosoftSampleApp
//
//  Created by Abhay Curam on 12/12/25.
//

import UIKit

public class StarWarsCharacterDetailViewController: UIViewController {
    
    private struct Constants {
        static let nameLabelField = "name: "
        static let genderLabelField = "gender: "
        static let hairColorLabelField = "hair color: "
        static let skinColorLabelField = "skin color: "
        static let eyeColorLabelField = "eye color: "
        static let heightLabelField = "height: "
        static let massLabelField = "mass: "
        static let birthYearLabelField = "birth year: "
        static let unknownValue = "unknown"
    }
    
    private let characterData: CharacterProperties
    
    private lazy var stackContentView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public init(_ characterData: CharacterProperties) {
        self.characterData = characterData
        super.init(nibName: nil, bundle: nil)
        navigationItem.title = "Character Details"
    }
    
    public override func viewDidLoad() {
        view.backgroundColor = UIColor.white
        view.addSubview(stackContentView)
        setupConstraints()
        updateStackViewWithData()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            stackContentView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            stackContentView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackContentView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    private func updateStackViewWithData() {
        if characterData.name != Constants.unknownValue {
            let labelView = createLabelView(Constants.nameLabelField, characterData.name)
            stackContentView.addArrangedSubview(labelView)
        }
        if characterData.gender != Constants.unknownValue {
            let labelView = createLabelView(Constants.genderLabelField, characterData.gender)
            stackContentView.addArrangedSubview(labelView)
        }
        if characterData.height != Constants.unknownValue {
            let labelView = createLabelView(Constants.heightLabelField, characterData.height)
            stackContentView.addArrangedSubview(labelView)
        }
        if characterData.mass != Constants.unknownValue {
            let labelView = createLabelView(Constants.massLabelField, characterData.mass)
            stackContentView.addArrangedSubview(labelView)
        }
        if characterData.hair_color != Constants.unknownValue {
            let labelView = createLabelView(Constants.hairColorLabelField, characterData.hair_color)
            stackContentView.addArrangedSubview(labelView)
        }
        if characterData.skin_color != Constants.unknownValue {
            let labelView = createLabelView(Constants.skinColorLabelField, characterData.skin_color)
            stackContentView.addArrangedSubview(labelView)
        }
        if characterData.eye_color != Constants.unknownValue {
            let labelView = createLabelView(Constants.eyeColorLabelField, characterData.eye_color)
            stackContentView.addArrangedSubview(labelView)
        }
        if characterData.birth_year != Constants.unknownValue {
            let labelView = createLabelView(Constants.birthYearLabelField, characterData.birth_year)
            stackContentView.addArrangedSubview(labelView)
        }
    }
    
    private func createLabelView(_ field: String,
                                 _ value: String) -> UILabel {
        let label = UILabel(frame: .zero)
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 20)
        label.attributedText = attributedTextForLabel(field, value)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    private func attributedTextForLabel(_ field: String,
                                        _ value: String) -> NSAttributedString {
        let mutableAttributedString = NSMutableAttributedString()
        let labelFieldFont = UIFont.systemFont(ofSize: 20, weight: .bold)
        let labelValueFont = UIFont.systemFont(ofSize: 20, weight: .regular)
        let fieldAttributes: [NSAttributedString.Key: Any] = [.font : labelFieldFont]
        let fieldAttributedString = NSAttributedString(string: field, attributes: fieldAttributes)
        let valueAttributes: [NSAttributedString.Key: Any] = [.font : labelValueFont]
        let valueAttributedString = NSAttributedString(string: value, attributes: valueAttributes)
        mutableAttributedString.append(fieldAttributedString)
        mutableAttributedString.append(valueAttributedString)
        return NSAttributedString(attributedString: mutableAttributedString)
    }
    
}
