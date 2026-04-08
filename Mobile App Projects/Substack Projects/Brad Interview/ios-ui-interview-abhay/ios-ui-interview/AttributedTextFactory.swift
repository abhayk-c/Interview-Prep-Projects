//
//  AttributedTextFactory.swift
//  ios-ui-interview
//
//  Created by Abhay Curam on 12/7/25.
//

import Foundation
import UIKit

public struct AttributedTextFactory {
    
    public static func attributedTextForHeading(_ heading: Heading) -> NSAttributedString {
        let mutableAttributedString = NSMutableAttributedString()
        let headingFont = UIFont.systemFont(ofSize: 30, weight: .bold)
        let headingLinkFont = UIFont.systemFont(ofSize: 28, weight: .regular)
        var headingItalicizedFont: UIFont? = nil
        if let descriptor = headingFont.fontDescriptor.withSymbolicTraits([.traitBold, .traitItalic]) {
            headingItalicizedFont = UIFont(descriptor: descriptor, size: 30)
        }
        
        for node in heading.children {
            if let textNode = node as? TextNode, !textNode.text.isEmpty {
                var attributesDictionary: [NSAttributedString.Key: Any] = [.font: headingFont]
                if textNode.italic || textNode.href != nil {
                    if textNode.italic, let italicFont = headingItalicizedFont {
                        attributesDictionary[.font] = italicFont
                    }
                    if let linkURL = textNode.href {
                        attributesDictionary[.font] = headingLinkFont
                        attributesDictionary[.link] = linkURL
                    }
                }
                let attributedString = NSAttributedString(string: textNode.text, attributes: attributesDictionary)
                mutableAttributedString.append(attributedString)
            } else if node is LineBreak {
                let attributedString = NSAttributedString(string: "\n")
                mutableAttributedString.append(attributedString)
            }
        }
        
        return NSAttributedString(attributedString: mutableAttributedString)
    }
    
    public static func attributedTextForParagraph(_ paragraph: Paragraph,
                                                  _ fontTraits: UIFontDescriptor.SymbolicTraits? = nil) -> NSAttributedString {
        let mutableAttributedString = NSMutableAttributedString()
        let systemParagraphFont = UIFont.systemFont(ofSize: 22, weight: .regular)
        let timesNewRomanParagraphFont = UIFont(name: "TimesNewRomanPSMT", size: 22)
        var timesNewRomanCustomTraitsFont: UIFont? = nil
        if let customTraits = fontTraits, let customFontDescriptor = timesNewRomanParagraphFont?.fontDescriptor.withSymbolicTraits(customTraits) {
            timesNewRomanCustomTraitsFont = UIFont(descriptor: customFontDescriptor, size: 22)
        }
        for node in paragraph.children {
            if let textNode = node as? TextNode, !textNode.text.isEmpty {
                let attributes: [NSAttributedString.Key: Any] = [.font: timesNewRomanCustomTraitsFont ?? timesNewRomanParagraphFont ?? systemParagraphFont]
                let attributedString = NSAttributedString(string: textNode.text, attributes: attributes)
                mutableAttributedString.append(attributedString)
            }
        }
        
        return NSAttributedString(attributedString: mutableAttributedString)
    }
    
    public static func attributedTextForCaption(_ caption: Caption) -> NSAttributedString {
        let mutableAttributedString = NSMutableAttributedString()
        let captionDefault = UIFont.systemFont(ofSize: 16, weight: .regular)
        let captionTimesNewRoman = UIFont(name: "TimesNewRomanPSMT", size: 18)
        let captionFontColor = UIColor.systemGray
        for node in caption.children {
            if let textNode = node as? TextNode, !textNode.text.isEmpty {
                let attributes: [NSAttributedString.Key: Any] = [.font: captionTimesNewRoman ?? captionDefault,
                                                                 .foregroundColor: captionFontColor]
                let attributedString = NSAttributedString(string: textNode.text, attributes: attributes)
                mutableAttributedString.append(attributedString)
            }
            else if let _ = node as? LineBreak {
                mutableAttributedString.append(NSAttributedString(string: "\n"))
            }
        }
        
        return NSAttributedString(attributedString: mutableAttributedString)
    }
    
    public static func attributedTextForBlockquote(_ blockquote: Blockquote) -> NSAttributedString {
        let mutableAttributedString = NSMutableAttributedString()
        for node in blockquote.children {
            if let paragraphNode = node as? Paragraph {
                let attributedString = AttributedTextFactory.attributedTextForParagraph(paragraphNode, [.traitBold, .traitItalic])
                mutableAttributedString.append(attributedString)
            }
            else if let captionNode = node as? Caption {
                mutableAttributedString.append(NSAttributedString(string: "\n"))
                let attributedString = AttributedTextFactory.attributedTextForCaption(captionNode)
                mutableAttributedString.append(attributedString)
            }
            else if let _ = node as? LineBreak {
                mutableAttributedString.append(NSAttributedString(string: "\n"))
            }
        }
        
        return NSAttributedString(attributedString: mutableAttributedString)
    }
    
}
