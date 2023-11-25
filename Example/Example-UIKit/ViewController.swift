//
//  ViewController.swift
//  Example-UIKit
//
//  Created by Mikhail Vospennikov on 13.02.2023.
//

import InteractiveImageView
import UIKit

class ViewController: UIViewController {
    lazy var imageView = InteractiveImageView(maxScale: 2.0)
    lazy var loaderView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .medium)
        view.color = .white
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureGestures()
        startLoadingImage()
    }

    fileprivate func configureHierarchy() {
        view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])

        view.addSubview(loaderView)
        loaderView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loaderView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loaderView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }

    fileprivate func configureGestures() {
        let doubleTapGesture = UITapGestureRecognizer(target: self, action: #selector(doubleTapGestureHandler))
        doubleTapGesture.numberOfTapsRequired = 2
        imageView.addGestureRecognizer(doubleTapGesture)
    }

    @objc
    fileprivate func doubleTapGestureHandler(_ sender: UITapGestureRecognizer) {
        let location = sender.location(in: imageView)
        imageView.zoom(to: location, animated: true)
    }

    fileprivate func startLoadingImage() {
        loaderView.startAnimating()
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) { [weak imageView, weak loaderView] in
            loaderView?.stopAnimating()
            imageView?.image = UIImage(named: "Iceland")
        }
    }
}
