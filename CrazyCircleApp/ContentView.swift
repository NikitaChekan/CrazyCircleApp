//
//  ContentView.swift
//  CrazyCircleApp
//
//  Created by jopootrivatel on 23.12.2023.
//

import SwiftUI

struct ContentView: View {
    
    @State private var movingCircle: CGSize = .zero
    
    var body: some View {
        Rectangle()
            .fill(
                RadialGradient(
                    gradient: .init(colors: [Color.yellow, Color.red]),
                    center: .center,
                    startRadius: 50,
                    endRadius: 150
                )
            )
            .mask {
                Canvas { context, size in
                    
                    context.addFilter(.alphaThreshold(min: 0.5))
                    context.addFilter(.blur(radius: 20))
                    
                    context.drawLayer { context in
                        context.draw(
                            context.resolveSymbol(id: 0)!,
                            at: CGPoint(
                                x: UIScreen.main.bounds.midX,
                                y: UIScreen.main.bounds.midY
                            )
                        )
                        context.draw(
                            context.resolveSymbol(id: 1)!,
                            at: CGPoint(
                                x: UIScreen.main.bounds.midX,
                                y: UIScreen.main.bounds.midY
                            )
                        )
                    }
                    
                } symbols: {
                    Circle()
                        .frame(width: 150)
                        .tag(0)
                    Circle()
                        .frame(width: 150)
                        .offset(movingCircle)
                        .tag(1)
                }
            }
            .overlay {
                Image(systemName: "cloud.sun.rain.fill")
                    .resizable()
                    .frame(width: 85, height: 80)
                    .offset(movingCircle)
                    .symbolRenderingMode(.hierarchical)
            }
            .gesture(
                DragGesture()
                    .onChanged { movingCircle = $0.translation }
                    .onEnded { _ in
                        withAnimation(.interpolatingSpring(stiffness: 180, damping: 20)) {
                            movingCircle = .zero
                        }
                        
                    }
            )
            .ignoresSafeArea()
    }
}

#Preview {
    ContentView()
}
