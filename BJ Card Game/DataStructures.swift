//
//  DataStructures.swift
//  BJ Card Game
//
//  Created by Kayla A. Yang  on 5/2/2024.
//

import Foundation

class Card{
    var suit: String
    var rank: String
    var value: Int
    var image: String
    
    init(suit: String, rank: String, value: Int) {
        self.suit = suit
        self.rank = rank
        self.value = value
        self.image = value < 10 ? suit + "0" + String(value) : suit + String(value)
    }
    
    func simpleDescription() -> String {
        return "The \(rank) of \(suit) has a value of \(value)"
    }
}

class Deck{
    var cards: [Card]
    
    init() {
        self.cards = Array<Card>()
    }
    
    static func createDeck() -> [Card]{
        let suits = ["Hearts","Diamonds","Clubs","Spades"]
        
        let ranks = ["Ace": 1, "Two": 2,"Three": 3,"Four": 4,"Five": 5,"Six": 6,"Seven": 7,"Eight": 8,"Nine": 9 ,"Ten": 10,"Jack": 11,"Queen": 12,"King": 13]
        
        var blankDeck: [Card] = []
        
        for suit in suits {
            for rank in ranks{
                let newCard = Card(suit: suit, rank: rank.key, value: rank.value)
                blankDeck.append(newCard)
            }
        }
        return blankDeck
    }
}

    class Player{
        var hand: [Card] = []
        var name: String
        var value: Int {
            
            var newValue = 0
            for card in self.hand{
                newValue = newValue + card.value
            }
            
            return newValue
        }
        
        init(name: String){
            self.name = name
            
        }
    }
    
