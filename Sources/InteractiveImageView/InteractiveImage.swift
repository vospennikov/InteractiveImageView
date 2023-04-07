//
//  InteractiveImage.swift
//  InteractiveImageView
//
//  Created by Mikhail Vospennikov on 23.12.2022.
//

import SwiftUI
import UIKit

public struct InteractiveImage: UIViewRepresentable {
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
    
    public func makeUIView(context: Context) -> InteractiveImageView {
        InteractiveImageView(image: image, maxScale: maxScale)
    }
    
    public func updateUIView(_ uiView: InteractiveImageView, context: Context) {
        context.coordinator.update(self, view: uiView)
    }
    
    public func makeCoordinator() -> Coordinator {
        Coordinator()
    }
}

extension InteractiveImage {
    final public class Coordinator {
        internal func update(_ representable: InteractiveImage, view interactiveImage: InteractiveImageView) {
            updateZoom(representable, view: interactiveImage)
        }
        
        private func updateZoom(_ representable: InteractiveImage, view interactiveImage: InteractiveImageView) {
            switch representable.handleZoomingTap {
                case .zero:
                    guard interactiveImage.minimumZoomScale != interactiveImage.zoomScale else { return }
                    interactiveImage.zoom(to: representable.handleZoomingTap, animated: representable.isAnimatedZooming)
                default:
                    interactiveImage.zoom(to: representable.handleZoomingTap, animated: representable.isAnimatedZooming)
            }
        }
    }
}
