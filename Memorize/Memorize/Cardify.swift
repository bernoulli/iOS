//
//  Cardify.swift
//  Memorize
//
//  Created by Bernardo Cuervo on 26/10/21.
//  Copyright © 2021 Bernardo Cuervo. All rights reserved.
//

import SwiftUI

struct Cardify: AnimatableModifier{
    var rotation: Double
    
    init(isFaceUp: Bool ){
        rotation = isFaceUp ? 0 : 180
    }
    
    var isFaceUp: Bool {
        rotation < 90
    }
    
    var animatableData: Double {
        get { return rotation }
        set { rotation = newValue }
        
    }
    
    func body(content: Content) -> some View {
        ZStack{
            Group {
                RoundedRectangle(cornerRadius: self.cornerRadius).fill().foregroundColor(.white)
                RoundedRectangle(cornerRadius: self.cornerRadius).stroke(lineWidth: edgeLineWidth)
                content
            }
                .opacity(isFaceUp ? 1 : 0)
            RoundedRectangle(cornerRadius: cornerRadius).fill()
                .opacity(isFaceUp ? 0 : 1)
        }
        .rotation3DEffect(Angle.degrees(rotation), axis: (0,1,0))

            
    }
    
    private let cornerRadius: CGFloat = 10
    private let edgeLineWidth: CGFloat = 3
}

extension View{
    func cardify(isFaceUp: Bool) -> some View{
        self.modifier(Cardify(isFaceUp: isFaceUp))
    }
}
