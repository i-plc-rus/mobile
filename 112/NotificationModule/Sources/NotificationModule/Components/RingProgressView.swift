//
//  SwiftUIView.swift
//  
//
//  Created by anbushmanov on 30.10.2024.
//

import SwiftUI

struct RingProgressView: View {
    
    enum ProgressSize {
        case medium
        case small
        
        var size: CGFloat {
            switch self {
            case .medium:
                40.0
                
            case .small:
                20.0
            }
        }
    }
    
    let progressSize: ProgressSize
    
    init(_ progressSize: ProgressSize) {
        self.progressSize = progressSize
    }
    
    var body: some View {
        ProgressView()
            .progressViewStyle(CirclesProgressViewStyle(height: progressSize.size))
            .frame(width: progressSize.size, height: progressSize.size)
    }
}

struct CirclesProgressViewStyle: ProgressViewStyle {
    
    @State private var isAnimating = false
    private let height: CGFloat
    
    init(height: CGFloat) {
        self.height = height
    }

    func makeBody(configuration: Configuration) -> some View {
        Circle()
            .trim(from: 0.25, to: 1.0)
            .stroke(
                Color.green,
                style: StrokeStyle(
                    lineWidth: height * 0.15,
                    lineCap: .round,
                    lineJoin: .round,
                    miterLimit: .zero,
                    dash: [],
                    dashPhase: 10.0
                )
            )
            .compositingGroup()
            .rotationEffect(.degrees(isAnimating ? 360.0 : 0.0))
            .animation(
                Animation
                    .linear(duration: 0.9)
                    .repeatForever(autoreverses: false),
                value: isAnimating
            )
            .onAppear {
                    isAnimating = true
            }
    }
}
