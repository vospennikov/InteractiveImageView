//
//  ContentView.swift
//  Example
//
//  Created by Mikhail Vospennikov on 26.12.2022.
//

import SwiftUI
import InteractiveImageView
import Gestures

struct ContentView: View {
    @State var tapLocation: CGPoint = .zero
    
    var body: some View {
        InteractiveImage(image: .init(named: "Iceland")!, maxScale: 3.0, handleZoomingTap: $tapLocation)
            .onTouchGesture(count: 2) { gesture in
                tapLocation = gesture.location
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
