//
//  main.swift
//  DesignProblems
//
//  Created by Abhay Curam on 8/16/25.
//

import Foundation

let cardDeck = Deck<BlackjackCard>()
var card = cardDeck.top()
print(card?.getRank())
print(card?.getSuite())
print(card?.getValues())
cardDeck.pop()
cardDeck.pop()
card = cardDeck.top()
print(card?.getRank())
print(card?.getSuite())
print(card?.getValues())


