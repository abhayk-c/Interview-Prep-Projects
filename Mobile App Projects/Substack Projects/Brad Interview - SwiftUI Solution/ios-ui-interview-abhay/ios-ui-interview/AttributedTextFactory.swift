//
//  AttributedTextFactory.swift
//  ios-ui-interview
//
//  Created by Abhay Curam on 11/26/26.
//

import Foundation

public struct AttributedTextFactory {
    
    static func attributedTextForHeading(_ heading: Heading) -> AttributedString {
        var result = AttributedString()
        for node in heading.children {
            if let textNode = node as? TextNode {
                var textNodeAttributes = AttributedString(textNode.text)
                if let link = textNode.href {
                    textNodeAttributes.link = link
                    textNodeAttributes.font = .system(size: 26)
                } else {
                    textNodeAttributes.foregroundColor = .black
                    textNodeAttributes.font = textNode.italic ? .system(size: 30, weight: .heavy).italic() : .system(size: 30, weight: .heavy)
                        
                }
                result.append(textNodeAttributes)
            }
            if let lineBreakNode = node as? LineBreak {
                let lineBreakAttributes = AttributedString("\n")
                result.append(lineBreakAttributes)
            }
        }
        return result
    }
    
    static func attributedTextForParagraph(_ paragraph: Paragraph) -> AttributedString {
        var result = AttributedString()
        for node in paragraph.children {
            if let textNode = node as? TextNode {
                var textAttributes = AttributedString(textNode.text)
                textAttributes.font = .custom("Times New Roman", size: 20)
                textAttributes.foregroundColor = .black
                result.append(textAttributes)
            }
        }
        return result
    }
    
    static func attributedTextForBlockquote(_ blockquote: Blockquote) -> (paragraphText: AttributedString, captionText: AttributedString) {
        var paragraphResult = AttributedString()
        var captionResult = AttributedString()
        for node in blockquote.children {
            if let paragraphNode = node as? Paragraph {
                for node in paragraphNode.children {
                    if let textNode = node as? TextNode {
                        var textAttributes = AttributedString(textNode.text)
                        textAttributes.font = .custom("Times New Roman", size: 20).bold().italic()
                        textAttributes.foregroundColor = .primary
                        paragraphResult.append(textAttributes)
                    }
                }
            } else if let captionNode = node as? Caption {
                for node in captionNode.children {
                    if let textNode = node as? TextNode {
                        var textAttributes = AttributedString(textNode.text)
                        textAttributes.font = .custom("Times New Roman", size: 16)
                        textAttributes.foregroundColor = .secondary
                        captionResult.append(textAttributes)
                    }
                }
            }
        }
        return (paragraphText: paragraphResult, captionText: captionResult)
    }
}
