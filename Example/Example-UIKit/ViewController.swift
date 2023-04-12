//
//  ViewController.swift
//  Example-UIKit
//
//  Created by Mikhail Vospennikov on 13.02.2023.
//

import UIKit
import InteractiveImageView

class ViewController: UIViewController {
    lazy var imageScroll = InteractiveImageView(maxScale: 2.0)
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
        view.addSubview(imageScroll)
        imageScroll.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageScroll.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageScroll.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageScroll.topAnchor.constraint(equalTo: view.topAnchor),
            imageScroll.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        view.addSubview(loaderView)
        loaderView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loaderView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loaderView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    fileprivate func configureGestures() {
        let doubleTapGesture = UITapGestureRecognizer(target: self, action: #selector(doubleTapGestureHandler))
        doubleTapGesture.numberOfTapsRequired = 2
        imageScroll.addGestureRecognizer(doubleTapGesture)
    }
    
    @objc
    fileprivate func doubleTapGestureHandler(_ sender: UITapGestureRecognizer) {
        let location = sender.location(in: imageScroll)
        imageScroll.zoom(to: location, animated: true)
    }
    
    fileprivate func startLoadingImage() {
        loaderView.startAnimating()
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) { [weak imageScroll, weak loaderView] in
            loaderView?.stopAnimating()
            imageScroll?.image = UIImage(named: "Iceland")
        }
    }
}
