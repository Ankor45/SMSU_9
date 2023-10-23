//
//  ContentView.swift
//  SMSU_9
//
//  Created by Andrei Kovryzhenko on 23.10.2023.
//

import SwiftUI

struct ContentView: View {
    
    @State private var position: CGSize = .zero
    private let centerWidth = UIScreen.main.bounds.width / 2
    private let centerHeight = UIScreen.main.bounds.height / 2
    
    var body: some View {
        ZStack {
            Color.blue
                .ignoresSafeArea()
            Canvas { context, size in
                let firstCircle = context.resolveSymbol(id: 0)!
                let secondCidrcle = context.resolveSymbol(id: 1)!
                
                context.addFilter(.alphaThreshold(min: 0.7,color: .white))
                context.addFilter(.blur(radius: 24))
                
                context.drawLayer { newContext in
                    newContext.draw(firstCircle, at: .init(x: centerWidth, y: centerHeight))
                    newContext.draw(secondCidrcle, at: .init(x: centerWidth, y: centerHeight))
                }
            } symbols: {
                Circle()
                    .frame(
                        width: 160,
                        height: 160,
                        alignment: .center
                    )
                    .tag(0)
                
                Circle()
                    .frame(
                        width: 160,
                        height: 160
                        , alignment: .center
                    )
                    .offset(x: position.width, y: position.height)
                    .tag(1)
            }
            .gesture(
                DragGesture()
                    .onChanged { gesture in
                        position = gesture.translation
                    }
                    .onEnded { gesture in
                        withAnimation(.spring(dampingFraction: 0.6)) {
                            position = .zero
                        }
                    }
            )
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
