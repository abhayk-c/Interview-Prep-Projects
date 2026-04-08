import UIKit

class PostViewController: UIViewController {
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: .zero)
        scrollView.isScrollEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = true
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 1.0
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var stackContentView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let dataProvider: DataProvider = .shared
    let imageDownloader: ImageDownloader = ImageDownloader()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        scrollView.addSubview(stackContentView)
        view.addSubview(scrollView)
        setupConstraintsOnScrollViewAndStackView()
        render(data: dataProvider.getPostContent())
    }
    
    func render(data: Document) {
        for contentNode in data.content {
            if let headingNode = contentNode as? Heading {
                let dynamicHeadingLabel = createLabel()
                dynamicHeadingLabel.attributedText = AttributedTextFactory.attributedTextForHeading(headingNode)
                stackContentView.addArrangedSubview(dynamicHeadingLabel)
            } else if let paragraphNode = contentNode as? Paragraph {
                let dynamicParagraphLabel = createLabel()
                dynamicParagraphLabel.attributedText = AttributedTextFactory.attributedTextForParagraph(paragraphNode)
                stackContentView.addArrangedSubview(dynamicParagraphLabel)
            } else if let imageNode = contentNode as? ImageNode {
                let imageContainer = createImageContainerView() //createImageView()
                stackContentView.addArrangedSubview(imageContainer)
                setupConstraintsForImageContainerView(imageContainer)
                imageDownloader.downloadImage(imageNode.src, .main) { image, error in
                    if let downloadedImage = image, error == nil {
                        imageContainer.image = downloadedImage
                    }
                }
            } else if let blockQuoteNode = contentNode as? Blockquote {
                let blockquoteView = createBlockquoteView(blockQuoteNode)
                stackContentView.addArrangedSubview(blockquoteView)
            }
        }
    }
    
    private func setupConstraintsForImageContainerView(_ imageContainerView: ImageContainerView) {
        NSLayoutConstraint.activate([
            imageContainerView.widthAnchor.constraint(equalTo: stackContentView.widthAnchor),
            imageContainerView.heightAnchor.constraint(equalTo: imageContainerView.widthAnchor, multiplier: 0.5)
        ])
    }
    
    private func setupConstraintsOnScrollViewAndStackView() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            stackContentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor, constant: 20),
            stackContentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor, constant: 20),
            stackContentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor, constant: -20),
            stackContentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor, constant: -20),
            stackContentView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor, constant: -40)
        ])
    }
    
    private func createLabel() -> UILabel {
        let label = UILabel(frame: .zero)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    private func createImageView() -> UIImageView {
        let imageView = UIImageView(frame: .zero)
        // Eye-balled it and looks like the image is roughly half the size of its containing
        // bounds and its a perfect square so we can take advantage of that.
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }
    
    private func createImageContainerView() -> ImageContainerView {
        let imageContainerView = ImageContainerView(frame: .zero)
        imageContainerView.translatesAutoresizingMaskIntoConstraints = false
        return imageContainerView
    }
    
    private func createBlockquoteView(_ blockquote: Blockquote) -> BlockquoteView {
        let blockquoteView = BlockquoteView(.zero, blockQuote: blockquote)
        blockquoteView.translatesAutoresizingMaskIntoConstraints = false
        return blockquoteView
    }
    
}

