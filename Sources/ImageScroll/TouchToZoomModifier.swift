//
//  TouchToZoomModifier.swift
//  ImageScroll
//
//  Created by Mikhail Vospennikov on 26.12.2022.
//

import SwiftUI

struct TouchToZoomModifier: ViewModifier {
    var count: Int
    @Binding var tapLocation: CGPoint

    func body(content: Content) -> some View {
        content.gesture(tapGesture)
    }
    
    var tapGesture: some Gesture {
        if #available(iOS 16.0, *) {
            return SpatialTapGesture(count: count)
                .onEnded { gesture in
                    tapLocation = gesture.location
                }
        } else {
            return SequenceGesture(TapGesture(count: count),
                                   DragGesture(minimumDistance: 0, coordinateSpace: .local)
                .onEnded { value in
                    guard ((value.startLocation.x - 1)...(value.startLocation.x + 1)).contains(value.location.x),
                          ((value.startLocation.y - 1)...(value.startLocation.y + 1)).contains(value.location.y) else {
                        return
                    }
                    tapLocation = value.location
                }
            )
        }
    }
}

public extension ImageScroll {
    func onTouchToZoom(count: Int, location: Binding<CGPoint>) -> some View {
        ModifiedContent(content: self, modifier: TouchToZoomModifier(count: count, tapLocation: location))
    }
}
