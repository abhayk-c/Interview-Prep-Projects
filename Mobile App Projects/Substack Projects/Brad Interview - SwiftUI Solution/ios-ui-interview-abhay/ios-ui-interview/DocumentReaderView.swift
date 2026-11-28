//
//  DocumentView.swift
//  ios-ui-interview
//
//  Created by Abhay Curam on 11/26/26.
//

import SwiftUI

public struct DocumentReaderView: View {
    
    public let document: Document
    
    public init(_ document: Document) {
        self.document = document
    }
    
    public var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                ForEach(document.content, id: \.id) { node in
                    if let heading = node as? Heading {
                        Text(AttributedTextFactory.attributedTextForHeading(heading))
                            .padding(.bottom, 20)
                    } else if let paragraph = node as? Paragraph {
                        Text(AttributedTextFactory.attributedTextForParagraph(paragraph))
                            .padding(.bottom, 20)
                    } else if let blockquote = node as? Blockquote {
                        let attributedText = AttributedTextFactory.attributedTextForBlockquote(blockquote)
                        BlockquoteView(attributedText.paragraphText, attributedText.captionText)
                    } else if let localImage = node as? LocalImageNode {
                        CenteredImageView(localImage.assetName, CGSize(width: localImage.width, height: localImage.height), 20, .bottom)
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding([.leading, .trailing], 20)
        }
        .padding([.top, .bottom], 20)
        .scrollBounceBehavior(.basedOnSize)
    }
    
    private struct BlockquoteView: View {
        
        private let paragraphText: AttributedString
        private let captionText: AttributedString
        
        init(_ paragraphText: AttributedString, _ captionText: AttributedString) {
            self.paragraphText = paragraphText
            self.captionText = captionText
        }
        
        var body: some View {
            HStack(spacing: 16) {
                Rectangle()
                    .fill(Color(red: 255/255, green: 119/255, blue: 49/255))
                    .frame(minWidth: 5, maxWidth: 5, maxHeight: .infinity)
                VStack(alignment: .leading, spacing: 16) {
                    Text(paragraphText)
                    Text(captionText)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        
    }
    
    private struct CenteredImageView: View {
            
        private let name: String
        private let size: CGSize
        private let padding: CGFloat
        private let edges: Edge.Set
        
        public init(_ name: String, _ size: CGSize, _ padding: CGFloat = 0, _ edges: Edge.Set = .all) {
            self.name = name
            self.size = size
            self.padding = padding
            self.edges = edges
        }
        
        var body: some View {
            HStack(spacing: 0) {
                Spacer()
                Image(name)
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: size.width, maxHeight: size.height)
                Spacer()
            }
            .padding(edges, padding)
        }
            
    }
    
}

#Preview {
    DocumentReaderView(DataProvider.shared.getPostContent())
}
