import Foundation

public class DataProvider {
    
    public static let shared = DataProvider()
    
    public func getPostContent() -> Document {
        return Document([
            Heading([
                TextNode("The Home for Great"),
                LineBreak(),
                TextNode("Writers "),
                TextNode("and ", italic: true),
                TextNode("Readers. "),
                LineBreak(),
                TextNode("Learn more", href: URL(string: "https://substack.com")!)
            ]),
            ImageNode(src: URL(string: "https://substack.com/img/home_page/telescope.png")!, width: 520, height: 520),
            Paragraph([
                TextNode("We believe that what you read matters and great writing is valuable. We're building a future where writers can flourish by being paid directly by readers.")
            ]),
            Blockquote([
                Paragraph([
                    TextNode("There's something wonderful and beautiful about writing just for readers. Because your people are there, you have to be accountable, but it's a very pure relationship.")
                ]),
                LineBreak(),
                Caption([
                    TextNode("Andrew Sullivan, The Weekly Dish"),
                    LineBreak(),
                    TextNode("Copyright 2003")
                ])
            ])
        ])
    }
    
}
