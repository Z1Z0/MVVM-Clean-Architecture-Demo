//
//  LoadingIndicatorManager.swift
//  MVVM Clean Architecture Demo
//
//  Created by Ahmed Abd Elaziz on 05/06/2024.
//

import UIKit
import NVActivityIndicatorView

class LoadingIndicatorManager {
    static let shared = LoadingIndicatorManager()
    
    private lazy var containerView: UIView = {
        let container = UIView()
        container.backgroundColor = UIColor(named: "MainButtonColor")
        container.layer.cornerRadius = 12
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()
    
    private lazy var activityIndicator: NVActivityIndicatorView = {
        let indicator = NVActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 45, height: 45),
                                                type: .lineSpinFadeLoader,
                                                color: UIColor.white,
                                                padding: nil)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    private func setupConstraints(view: UIView) {
        NSLayoutConstraint.activate([
            containerView.widthAnchor.constraint(equalToConstant: 80),
            containerView.heightAnchor.constraint(equalToConstant: 80),
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor  ),
            activityIndicator.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
        ])
    }
    
    private init() {}
    
    func startLoading(in view: UIView) {
        stopLoading()
        
        containerView.frame = view.bounds
        view.addSubview(containerView)
        containerView.addSubview(activityIndicator)
        
        setupConstraints(view: view)
        
        activityIndicator.startAnimating()
    }
    
    func stopLoading() {
        activityIndicator.stopAnimating()
        containerView.removeFromSuperview()
    }
}
