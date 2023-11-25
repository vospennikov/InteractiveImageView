//
//  ContentView.swift
//  Example
//
//  Created by Mikhail Vospennikov on 26.12.2022.
//

import Gestures
import InteractiveImageView
import SwiftUI

struct ContentView: View {
    @State var fingerPosition: CGPoint?
    @State var tapLocation: CGPoint = .zero

    var body: some View {
        ZStack {
            Color.black

            InteractiveImage(
                image: .iceland,
                maxScale: 2.0,
                handleZoomingTap: $tapLocation
            )
            .onTouchGesture(count: 2) { gesture in
                tapLocation = gesture.location
                handleFingerGesture(gesture)
            }

            if let fingerPosition {
                Finger(position: fingerPosition)
            }
        }
        .onTouchGesture { gesture in
            handleFingerGesture(gesture)
        }
        .edgesIgnoringSafeArea(.all)
    }
}

// MARK: -
private extension ContentView {
    @MainActor
    func handleFingerGesture(_ gesture: TouchGesture.Value) {
        fingerPosition = gesture.location
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
            fingerPosition = nil
        }
    }

    @ViewBuilder
    func Finger(position: CGPoint) -> some View {
        ZStack {
            Circle()
                .fill(Color(red: 0.85, green: 0.85, blue: 0.85).opacity(0.75))
                .shadow(color: .black.opacity(0.40), radius: 8, x: 4, y: 4)
            Circle()
                .strokeBorder(Color(red: 0.65, green: 0.65, blue: 0.65), lineWidth: 1)
        }
        .frame(width: 42, height: 42)
        .position(position)
        .transition(.opacity.animation(.interactiveSpring()))
    }
}

// MARK: - Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
