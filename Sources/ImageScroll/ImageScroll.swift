//
//  ImageScroll.swift
//  ImageScroll
//
//  Created by Mikhail Vospennikov on 23.12.2022.
//

import SwiftUI
import UIKit

public struct ImageScroll: UIViewRepresentable {
    let image: UIImage
    let maxScale: CGFloat
    @Binding var handleZoomingTap: CGPoint
    var isAnimatedZooming: Bool
    
    public init(image: UIImage,
                maxScale: CGFloat = 1.0,
                handleZoomingTap: Binding<CGPoint> = .constant(.zero),
                isAnimatedZooming: Bool = true) {
        
        self.image = image
        self.maxScale = maxScale
        self._handleZoomingTap = handleZoomingTap
        self.isAnimatedZooming = isAnimatedZooming
    }
    
    public func makeUIView(context: Context) -> ImageScrollView {
        ImageScrollView(image: image, maxScale: maxScale)
    }
    
    public func updateUIView(_ uiView: ImageScrollView, context: Context) {
        context.coordinator.update(self, view: uiView)
    }
    
    public func makeCoordinator() -> Coordinator {
        Coordinator()
    }
}

extension ImageScroll {
    final public class Coordinator {
        internal func update(_ representable: ImageScroll, view imageScroll: ImageScrollView) {
            updateZoom(representable, view: imageScroll)
        }
        
        private func updateZoom(_ representable: ImageScroll, view imageScroll: ImageScrollView) {
            switch representable.handleZoomingTap {
                case .zero:
                    guard imageScroll.minimumZoomScale != imageScroll.zoomScale else { return }
                    imageScroll.zoom(to: representable.handleZoomingTap, animated: representable.isAnimatedZooming)
                default:
                    imageScroll.zoom(to: representable.handleZoomingTap, animated: representable.isAnimatedZooming)
            }
        }
    }
}
