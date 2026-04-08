//
//  TextEditorUndoRedo.swift
//  LeetcodeProblems
//
//  Created by Abhay Curam on 10/7/25.
//

/**
 * To start, we'll implement two types of operations we'd like to implement:
 * 1) InsertAtEndOperation: this will allow a user to append a string to the end
 *    of the document.
 * 2) DeleteFromEndOperation: this will allow a user to delete the last n chars
 *    from the document.
 */

enum PreviousOperation {
    case sentinel
    case insertAtEnd(charsToInsert: String)
    case deleteFromEnd(numCharsToDelete: Int, deletedString: String)
}

enum Operation {
    case insertAtEnd(charsToInsert: String)
    case deleteFromEnd(numCharsToDelete: Int)
}

class TextDocument {
    
    private var textBuffer: String = ""
    private var undoStack: [PreviousOperation] = []
    private var redoStack: [PreviousOperation] = []
    
    /**
     * Applies the given operation to the document.
     */
    func applyOperation(_ op: Operation, _ clearRedo: Bool = true) {
        if clearRedo { redoStack.removeAll() }
        var previousOperation: PreviousOperation = .sentinel
        switch op {
            case .insertAtEnd(let charsToInsert):
                textBuffer.append(charsToInsert)
                previousOperation = .insertAtEnd(charsToInsert: charsToInsert)
            case .deleteFromEnd(let numCharsToDelete):
                var deletedString = ""
                var counter = 0
                while counter < numCharsToDelete {
                    if let characterToInsert = textBuffer.popLast() {
                        deletedString.append(characterToInsert)
                    }
                    counter += 1
                }
                previousOperation = .deleteFromEnd(numCharsToDelete: numCharsToDelete, deletedString: String(deletedString.reversed()))
        }
        
        undoStack.append(previousOperation)
    }
    
    func undoLast() {
        if let recentOperation = undoStack.popLast() {
            switch recentOperation {
                case .insertAtEnd(let charsToInsert):
                    textBuffer.removeLast(charsToInsert.count)
                case .deleteFromEnd(_, let deletedString):
                    textBuffer.append(deletedString)
                case .sentinel:
                    print("hello")
            }
            redoStack.append(recentOperation)
        }
    }


    func redoLast() {
        if let recentOperation = redoStack.popLast() {
            var operation: Operation? = nil
            switch recentOperation {
                case .insertAtEnd(let charsToInsert):
                    operation = .insertAtEnd(charsToInsert: charsToInsert)
                case .deleteFromEnd(let numCharsToDelete, _):
                    operation = .deleteFromEnd(numCharsToDelete: numCharsToDelete)
                case .sentinel:
                    print("hello")
            }
            if let unwrappedOperation = operation {
                applyOperation(unwrappedOperation, false)
            }
        }
    }

    func getCurrentContent() -> String {
        return textBuffer
    }
}

func assertCurrentContent(_ doc: TextDocument, _ expected: String) {
    let currentContent = doc.getCurrentContent()
    if currentContent != expected {
        print("Expected \"\(expected)\", actual \"\(currentContent)\"")
    }
}



