//
//  ContentView.swift
//  Example
//
//  Created by Mikhail Vospennikov on 26.12.2022.
//

import SwiftUI
import ImageScroll

struct ContentView: View {
    @State var tapLocation: CGPoint = .zero
    
    var body: some View {
        ImageScroll(image: .init(named: "Iceland")!, maxScale: 3.0, handleZoomingTap: $tapLocation)
            .onTouchToZoom(count: 2, location: $tapLocation)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
