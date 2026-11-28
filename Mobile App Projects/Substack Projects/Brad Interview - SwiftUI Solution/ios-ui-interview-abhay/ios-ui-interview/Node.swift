import Foundation

public protocol Node: Identifiable {
    var id: UUID { get }
}

public struct LineBreak: Node {
    public let id = UUID()
}

public struct TextNode: Node {
    public let id = UUID()
    public let text: String
    public let italic: Bool
    public let href: URL?
    
    public init(_ text: String, italic: Bool = false, href: URL? = nil) {
        self.text = text
        self.italic = italic
        self.href = href
    }
}

public struct LocalImageNode: Node {
    public let id = UUID()
    public let assetName: String
    public let width: Int
    public let height: Int
}

public struct RemoteImageNode: Node {
    public let id = UUID()
    public let src: URL
    public let width: Int
    public let height: Int
}

public struct Document {
    public let content: [any Node]
    
    public init(_ content: [any Node]) {
        self.content = content
    }
}

public struct Heading: Node {
    public let id = UUID()
    public let children: [any Node]
    
    public init(_ children: [any Node]) {
        self.children = children
    }
}

public struct Paragraph: Node {
    public let id = UUID()
    public let children: [any Node]
    
    public init(_ children: [any Node]) {
        self.children = children
    }
}

public struct Blockquote: Node {
    public let id = UUID()
    public let children: [any Node]
    
    public init(_ children: [any Node]) {
        self.children = children
    }
}

public struct Caption: Node {
    public let id = UUID()
    public let children: [any Node]
    
    public init(_ children: [any Node]) {
        self.children = children
    }
}
