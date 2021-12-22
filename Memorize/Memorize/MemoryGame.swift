//
//  MemoryGame.swift
//  Model
//  Memorize
//
//  Created by Bernardo Cuervo on 1/07/20.
//  Copyright © 2020 Bernardo Cuervo. All rights reserved.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable{
    private(set) var cards: Array<Card>
    
    private var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get{ cards.indices.filter{ cards[$0].isFaceUp }.only }
        set{
            for index in cards.indices {
               cards[index].isFaceUp = index == newValue
                
            }
        }
    }
    
    mutating func choose(card: Card){
        print("card choosen \(card)")
        if let chosenIndex: Int = cards.firstIndex(matching: card), !cards[chosenIndex].isFaceUp, !cards[chosenIndex].isMatched{
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                if cards[chosenIndex].content == cards[potentialMatchIndex].content{
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                }
                self.cards[chosenIndex].isFaceUp = true
            }else {
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }
            
           
        }
        
    }
    
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent ){
        cards = Array<Card>()
        let random = Int.random(in: 1...5)
        for pairIndex in 0..<random{
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content, id: pairIndex*2))
            cards.append(Card(content: content, id: pairIndex*2+1))
            
        }
        cards.shuffle()
    }
    
    struct Card: Identifiable{//protocol
        
        var isFaceUp: Bool = false {
            didSet {
                if isFaceUp {
                    startUsingBonusTime()
                }else {
                     stoptUsingBonusTime()
                }
            }
        }
            
        var isMatched: Bool = false {
            didSet {
                stoptUsingBonusTime()
            }
        }
        var content: CardContent
        var id:  Int
    
    
    //Mark: - Bonus Time
    
    var bonusTimeLimit: TimeInterval = 6
    
    private var faceUpTime: TimeInterval {
        if let lastFaceUpDate = self.lastFaceUpDate {
            return pastFaceUpTime + Date().timeIntervalSince(lastFaceUpDate)
        }else {
            return pastFaceUpTime
        }
    }
    
    var lastFaceUpDate: Date?
    
    var pastFaceUpTime: TimeInterval = 0
    
    var bonusTimeRemaining: TimeInterval {
        max(0, bonusTimeLimit - faceUpTime)
    }
    
    var bonusRemaining: Double {
        (bonusTimeLimit > 0 && bonusTimeRemaining > 0) ? bonusTimeRemaining/bonusTimeLimit : 0
    }
    
    var hasEarnedBonus: Bool {
        isMatched && bonusTimeRemaining > 0
    }
    
    var isConsumingBonusTime: Bool {
        isFaceUp && !isMatched && bonusTimeRemaining > 0
    }
    
    private mutating func startUsingBonusTime() {
        if isConsumingBonusTime, lastFaceUpDate == nil {
            lastFaceUpDate = Date()
        }
    }
    
    private mutating func stoptUsingBonusTime() {
        pastFaceUpTime = faceUpTime
        self.lastFaceUpDate = nil
        
    }
    
    }
}
