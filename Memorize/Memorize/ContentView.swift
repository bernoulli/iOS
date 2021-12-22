//
//  ContentView.swift
//  Memorize
//
//  Created by Bernardo Cuervo on 27/06/20.
//  Copyright © 2020 Bernardo Cuervo. All rights reserved.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    var viewModel: EmojiMemoryGame
    
    var body: some View {
        HStack{
            ForEach(viewModel.cards) { card in
                CardView(card: card).onTapGesture {
                    self.viewModel.choose(card: card)
                }
            }	
        }
            .padding()
            .foregroundColor(Color.orange)
            .font(Font.largeTitle)
            //.aspectRatio(0.75, contentMode: .fit)
    }
 
}


struct CardView: View{
    
    var card: MemoryGame<String>.Card

    var body: some View{
        
        ZStack {
            //let shape = RoundedRectangle(cornerRadius: 20)
            
            if card.isFaceUp{
                RoundedRectangle(cornerRadius: 10).fill().foregroundColor(.white)
                RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 3)
                Text(card.content)
                    
            }else{
                RoundedRectangle(cornerRadius: 10.0).fill()
            }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        //ContentView()
        EmojiMemoryGameView(viewModel: EmojiMemoryGame())
    }
}




