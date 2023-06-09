//
//  InteractiveImageView.swift
//  InteractiveImageView
//
//  Created by Mikhail Vospennikov on 23.12.2022.
//

import UIKit

public final class InteractiveImageView: UIScrollView {
    private var contentView: UIImageView?
    private var imageSize: CGSize = .zero
    
    public var image: UIImage? {
        didSet {
            if let currentImage = contentView?.image,
               currentImage == image {
                return
            }
            display(image: image)
        }
    }
    public var maxScale: CGFloat = 1.0
    
    public init(frame: CGRect = .zero, image: UIImage? = nil, maxScale: CGFloat = 1.0) {
        self.image = image
        self.imageSize = image?.size ?? .zero
        self.maxScale = maxScale
        super.init(frame: frame)
        setupView()
    }
    
    @available(*, unavailable)
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false
        decelerationRate = .fast
        clipsToBounds = true
        delegate = self
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        guard let image = image else { return }
        
        let displayedImage = contentView?.image
        if image != displayedImage {
            display(image: image)
        }
        
        moveContentToCenter()
    }
    
    var restorePoint: CGPoint = .zero
    var restoreScale: CGFloat = .leastNonzeroMagnitude
    public override var frame: CGRect {
        willSet {
            if frame != newValue, newValue != .zero, imageSize != .zero {
                restorePoint = pointToCenterAfterRotation()
                restoreScale = scaleToRestoreAfterRotation()
            }
        }
        didSet {
            if frame != oldValue, frame != .zero, imageSize != .zero {
                configure(for: imageSize)
                restoreCenterPoint(to: restorePoint, oldScale: restoreScale)
            }
        }
    }
}

// MARK: - Display content
extension InteractiveImageView {
    private func display(image: UIImage?) {
        zoomScale = 1.0
        
        if let contentView = contentView {
            contentView.removeFromSuperview()
        }
        guard let image = image else {
            contentView?.image = nil
            return
        }
        
        let contentView = UIImageView(image: image)
        contentView.isUserInteractionEnabled = true
        self.contentView = contentView
        addSubview(contentView)
        
        configure(for: image.size)
    }
    
    private func configure(for size: CGSize) {
        imageSize = size
        contentSize = size
        configureZoomScale()
        zoomScale = minimumZoomScale
    }
}

// MARK: - Position
extension InteractiveImageView {
    private func moveContentToCenter() {
        guard let contentView = contentView else { return }
        
        let boundsSize = bounds.size
        var frameToCenter = contentView.frame
        
        if frameToCenter.size.width < boundsSize.width {
            frameToCenter.origin.x = (boundsSize.width - frameToCenter.size.width) / 2
        } else {
            frameToCenter.origin.x = 0
        }
        
        if frameToCenter.size.height < boundsSize.height {
            frameToCenter.origin.y = (boundsSize.height - frameToCenter.size.height) / 2
        } else {
            frameToCenter.origin.y = 0
        }
        
        contentView.frame = frameToCenter
    }
}

// MARK: - Zoom
extension InteractiveImageView {
    public func zoom(to point: CGPoint, animated: Bool) {
        guard minimumZoomScale != maximumZoomScale, minimumZoomScale < maximumZoomScale else {
            return
        }
        
        let scale: CGFloat
        if zoomScale == minimumZoomScale {
            scale = maximumZoomScale
        } else {
            scale = minimumZoomScale
        }
        
        let contentLocation = convert(point, to: contentView)
        let zoomRect = makeZoomRect(for: scale, with: contentLocation)
        
        zoom(to: zoomRect, animated: animated)
    }
    
    private func makeZoomRect(for scale: CGFloat, with center: CGPoint) -> CGRect {
        var zoomRect: CGRect = .zero
        zoomRect.size.width = bounds.size.width / scale
        zoomRect.size.height = bounds.size.height / scale
        zoomRect.origin.x = center.x - zoomRect.size.width / 2
        zoomRect.origin.y = center.y - zoomRect.size.height / 2
        return zoomRect
    }
    
    private func configureZoomScale() {
        guard imageSize != .zero else { return }
        
        let xScale =  bounds.size.width  / imageSize.width
        let yScale = bounds.size.height / imageSize.height
        var minScale = max(min(xScale, yScale), .ulpOfOne)
        
        if (minScale > maxScale) {
            minScale = maxScale
        }
        
        maximumZoomScale = maxScale
        minimumZoomScale = minScale
    }
}

// MARK: - Device rotation
extension InteractiveImageView {
    private func restoreCenterPoint(to oldCenter: CGPoint, oldScale: CGFloat) {
        zoomScale = min(maximumZoomScale, max(minimumZoomScale, oldScale))
        
        let boundsCenter = convert(oldCenter, from: contentView)
        var offset = CGPoint(x: boundsCenter.x - bounds.size.width / 2, y: boundsCenter.y - bounds.size.height / 2)
        
        let maxOffset = maximumContentOffset()
        let minOffset = minimumContentOffset()
        offset.x = max(minOffset.x, min(maxOffset.x, offset.x))
        offset.y = max(minOffset.y, min(maxOffset.y, offset.y))
        
        contentOffset = offset
    }
    
    private func pointToCenterAfterRotation() -> CGPoint {
        let boundsCenter = CGPoint(x: bounds.midX, y: bounds.midY)
        return convert(boundsCenter, to: contentView)
    }
    
    private func scaleToRestoreAfterRotation() -> CGFloat {
        var contentScale = zoomScale
        if contentScale <= minimumZoomScale + .ulpOfOne {
            contentScale = 0
        }
        return contentScale
    }
    
    private func maximumContentOffset() -> CGPoint {
        let contentSize = contentSize
        let boundSize = bounds.size
        return CGPoint(x: contentSize.width - boundSize.width, y: contentSize.height - boundSize.height)
    }
    
    private func minimumContentOffset() -> CGPoint {
        .zero
    }
}

// MARK: - UIScrollViewDelegate
extension InteractiveImageView: UIScrollViewDelegate {
    public func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        contentView
    }
    
    public func scrollViewDidZoom(_ scrollView: UIScrollView) {
        moveContentToCenter()
    }
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        moveContentToCenter()
    }
}
