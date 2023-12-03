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
    let maximumZoomScale: CGFloat
    var zoomInteraction: ZoomInteraction

    public struct ZoomInteraction: Equatable {
        public var location: CGPoint
        public var scale: CGFloat
        public var animated: Bool

        public init(location: CGPoint = .zero, scale: CGFloat = 1.0, animated: Bool = true) {
            self.location = location
            self.scale = scale
            self.animated = animated
        }
    }

    public init(
        image: UIImage,
        maximumZoomScale: CGFloat = 1.0,
        zoomInteraction: ZoomInteraction
    ) {
        self.image = image
        self.maximumZoomScale = maximumZoomScale
        self.zoomInteraction = zoomInteraction
    }

    public init(
        image: UIImage,
        maximumZoomScale: CGFloat = 1.0,
        location: CGPoint
    ) {
        self.image = image
        self.maximumZoomScale = maximumZoomScale
        zoomInteraction = .init(location: location)
    }

    public func makeUIView(context: Context) -> InteractiveImageView {
        InteractiveImageView(image: image, maxScale: maximumZoomScale)
    }

    public func updateUIView(_ uiView: InteractiveImageView, context: Context) {
        context.coordinator.update(self, view: uiView)
    }

    public func makeCoordinator() -> Coordinator {
        Coordinator()
    }
}

public extension InteractiveImage {
    @MainActor
    final class Coordinator {
        func update(_ representable: InteractiveImage, view interactiveImage: InteractiveImageView) {
            updateZoom(representable, view: interactiveImage)
        }

        private func updateZoom(_ representable: InteractiveImage, view interactiveImage: InteractiveImageView) {
            interactiveImage.zoom(
                to: representable.zoomInteraction.location,
                scale: representable.zoomInteraction.scale,
                animated: representable.zoomInteraction.animated
            )
        }
    }
}
