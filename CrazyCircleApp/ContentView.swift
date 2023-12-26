//
//  ContentView.swift
//  CrazyCircleApp
//
//  Created by jopootrivatel on 23.12.2023.
//

import SwiftUI

struct ContentView: View {
    
    @State private var movingCircle = CGSize.zero
    
    var body: some View {
        ZStack {
            Circle()
                .foregroundColor(.yellow)
            ZStack {
                Circle()
                    .foregroundColor(.red)
                Image(systemName: "cloud.sun.rain.fill")
                    .resizable()
                    .frame(width: 80, height: 75)
            }
            .offset(movingCircle)
            .gesture(
                DragGesture()
                    .onChanged { movingCircle = $0.translation }
                    .onEnded { _ in
                        withAnimation(.spring) {
                            movingCircle = .zero
                        }
                        
                    }
            )
        }
        .frame(width: 150)
    }
}

#Preview {
    ContentView()
}
