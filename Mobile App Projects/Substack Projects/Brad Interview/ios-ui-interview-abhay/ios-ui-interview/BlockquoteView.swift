//
//  BlockquoteView.swift
//  ios-ui-interview
//
//  Created by Abhay Curam on 12/11/25.
//

import UIKit

public class BlockquoteView: UIView {
    
    public override var intrinsicContentSize: CGSize {
        let blockQuoteLabelSize = blockquoteLabel.intrinsicContentSize
        return CGSize(width: blockQuoteLabelSize.width + 5 + 10, height: blockQuoteLabelSize.height)
    }
    
    private lazy var blockquoteLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.numberOfLines = 0
        label.textAlignment = .left
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var blockquoteDividerView: UIView = {
        let dividerView = UIView(frame: .zero)
        dividerView.backgroundColor = UIColor(red: 255/255, green: 119/255, blue: 49/255, alpha: 1.0)
        dividerView.translatesAutoresizingMaskIntoConstraints = false
        return dividerView
    }()
    
    public init(_ frame: CGRect, blockQuote: Blockquote) {
        super.init(frame: frame)
        blockquoteLabel.attributedText = AttributedTextFactory.attributedTextForBlockquote(blockQuote)
        addSubview(blockquoteLabel)
        addSubview(blockquoteDividerView)
        setupConstraints()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        invalidateIntrinsicContentSize()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            blockquoteDividerView.topAnchor.constraint(equalTo: topAnchor),
            blockquoteDividerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            blockquoteDividerView.widthAnchor.constraint(equalToConstant: 5),
            blockquoteDividerView.heightAnchor.constraint(equalTo: blockquoteLabel.heightAnchor),
            blockquoteLabel.topAnchor.constraint(equalTo: topAnchor),
            blockquoteLabel.leadingAnchor.constraint(equalTo: blockquoteDividerView.trailingAnchor, constant: 10),
            blockquoteLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
}
