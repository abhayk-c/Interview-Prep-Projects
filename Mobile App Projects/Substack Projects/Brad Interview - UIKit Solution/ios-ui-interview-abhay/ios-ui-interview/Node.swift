import Foundation

public protocol Node {}

public struct LineBreak: Node {}

public struct TextNode: Node {
    public let text: String
    public let italic: Bool
    public let href: URL?
    
    public init(_ text: String, italic: Bool = false, href: URL? = nil) {
        self.text = text
        self.italic = italic
        self.href = href
    }
}

public struct ImageNode: Node {
    public let src: URL
    public let width: Int
    public let height: Int
}

public struct Document {
    public let content: [Node]
    
    public init(_ content: [Node]) {
        self.content = content
    }
}

public struct Heading: Node {
    public let children: [Node]
    
    public init(_ children: [Node]) {
        self.children = children
    }
}

public struct Paragraph: Node {
    public let children: [Node]
    
    public init(_ children: [Node]) {
        self.children = children
    }
}

public struct Blockquote: Node {
    public let children: [Node]
    
    public init(_ children: [Node]) {
        self.children = children
    }
}

public struct Caption: Node {
    public let children: [Node]
    
    public init(_ children: [Node]) {
        self.children = children
    }
}
