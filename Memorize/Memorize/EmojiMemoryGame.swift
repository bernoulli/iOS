//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Bernardo Cuervo on 1/07/20.
//  Copyright © 2020 Bernardo Cuervo. All rights reserved.
//

import SwiftUI
 

class EmojiMemoryGame: ObservableObject {
    @Published private var model: MemoryGame<String> = createMemoryGame()
    
    private static func createMemoryGame() -> MemoryGame<String>{
        let emojis: Array<String> = ["👻","🎃","🕷","👽","💀","🥴","🤡","😺","🎅🏻","👩🏿‍🚀","🧛🏽‍♀️","🧟"].shuffled()
        
        return  MemoryGame<String>(numberOfPairsOfCards: emojis.count) { pairIndex in
        return emojis[pairIndex]
        }
    }
        
    
        
    
    //MARK: - Access to the Model
    
    var cards: Array<MemoryGame<String>.Card>{
        model.cards
    }
     
    //MARK: - Intent(s)
    
    func choose(card: MemoryGame<String>.Card){
        //objectWillChange.send()
        model.choose(card: card)
    }
    
    func resetGame(){
        model = EmojiMemoryGame.createMemoryGame()
    }
    
}
 
/*
struct EmojiMemoryGame_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
*/
