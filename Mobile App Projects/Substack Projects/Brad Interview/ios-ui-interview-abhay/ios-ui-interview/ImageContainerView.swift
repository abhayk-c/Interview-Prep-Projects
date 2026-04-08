//
//  ImageNodeView.swift
//  ios-ui-interview
//
//  Created by Abhay Curam on 12/11/25.
//

import UIKit

/**
 * A ContainerView that displays a UIImageView centered within
 * the container. Useful for StackView's and VStack interfaces.
 */
public class ImageContainerView: UIView {
    
    public var image: UIImage? {
        didSet {
            if let unwrappedImage = image {
                imageView.image = unwrappedImage
            }
        }
    }
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imageView)
        setupConstraints()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalTo: heightAnchor),
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor),
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
}
