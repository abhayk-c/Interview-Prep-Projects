//
//  RichTextBlock.swift
//  NotionDocumentStore
//
//  Created by Abhay Curam on 10/5/25.
//

import Foundation
import AppKit

public class RichTextBlock: Block {
    public private(set) var blockID: String
    public var richText: NSMutableAttributedString?
    public init(_ richText: NSMutableAttributedString?, _ blockID: String) {
        self.richText = richText
        self.blockID = blockID
    }
}

public enum HeadingBlockStyle {
    case headingOne
    case headingTwo
    case headingThree
}

public struct TextBlockFactory {
    
    public static func createTitleBlock(_ text: String) -> RichTextBlock {
        let attributesDict: [NSAttributedString.Key : Any] = [
            .font: NSFont.systemFont(ofSize: 28)
        ]
        let attributedTitleText = NSMutableAttributedString(string: text, attributes: attributesDict)
        return RichTextBlock(attributedTitleText, UUID().uuidString)
    }
    
    public static func createHeadingBlock(_ text: String, _ style: HeadingBlockStyle) -> RichTextBlock {
        var fontSize: CGFloat = 0
        switch style {
        case .headingOne:
            fontSize = 24
        case .headingTwo:
            fontSize = 21
        case .headingThree:
            fontSize = 18
        }
        
        let attributesDict: [NSAttributedString.Key : Any] = [
            .font: NSFont.systemFont(ofSize: fontSize)
        ]
        let attributedTitleText = NSMutableAttributedString(string: text, attributes: attributesDict)
        return RichTextBlock(attributedTitleText, UUID().uuidString)
    }
    
}


