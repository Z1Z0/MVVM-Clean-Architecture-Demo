//
//  ToastAlertView.swift
//  MVVM Clean Architecture Demo
//
//  Created by Ahmed Abd Elaziz on 05/06/2024.
//

import UIKit

enum ToastType {
    
    case success
    case failure
    
    var backgroundColor: UIColor {
        switch self {
        case .success:
            return UIColor(named: "MainButtonColor")!
        case .failure:
            return .systemRed
        }
    }
    
    var image: UIImage {
        let config = UIImage.SymbolConfiguration(pointSize: 32)
        switch self {
        case .success:
            return UIImage(systemName: "checkmark.circle.fill", withConfiguration: config)!
        case .failure:
            return UIImage(systemName: "xmark.circle.fill", withConfiguration: config)!
        }
    }
}

class Toast {
    
    static func show(type: ToastType, title: String, message: String, textColor: UIColor, imageColor: UIColor, controller: UIViewController) {
        
        lazy var toastContainer: UIView = {
            let toastContainer = UIView()
            toastContainer.backgroundColor = type.backgroundColor
            toastContainer.alpha = 0.0
            toastContainer.layer.cornerRadius = 25
            toastContainer.clipsToBounds  =  true
            toastContainer.translatesAutoresizingMaskIntoConstraints = false
            return toastContainer
        }()
        
        lazy var statusImage: UIImageView = {
            let statusImage = UIImageView()
            statusImage.image = type.image.withTintColor(imageColor, renderingMode: .alwaysOriginal)
            statusImage.contentMode = .scaleAspectFit
            statusImage.translatesAutoresizingMaskIntoConstraints = false
            return statusImage
        }()
        
        lazy var titleAndDescriptionStackView: UIStackView = {
            let stack = UIStackView()
            stack.axis = .vertical
            stack.distribution = .fill
            stack.translatesAutoresizingMaskIntoConstraints = false
            return stack
        }()
        
        lazy var titleLabel: UILabel = {
            let label = UILabel()
            label.font = UIFont(name: "AvenirNext-DemiBold", size: 12)
            label.text = title
            label.textColor = textColor
            label.textAlignment = .left
            label.numberOfLines = 0
            label.clipsToBounds  =  true
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        lazy var descriptionLabel: UILabel = {
            let label = UILabel()
            label.font = UIFont(name: "AvenirNext-Regular", size: 10)
            label.text = message
            label.textColor = textColor
            label.textAlignment = .left
            label.numberOfLines = 0
            label.clipsToBounds  =  true
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()

        toastContainer.addSubview(statusImage)
        toastContainer.addSubview(titleAndDescriptionStackView)
        titleAndDescriptionStackView.addArrangedSubview(titleLabel)
        titleAndDescriptionStackView.addArrangedSubview(descriptionLabel)
        controller.view.addSubview(toastContainer)
        
        NSLayoutConstraint.activate([
            statusImage.leadingAnchor.constraint(equalTo: toastContainer.leadingAnchor, constant: 16),
            statusImage.centerYAnchor.constraint(equalTo: toastContainer.centerYAnchor),
            statusImage.widthAnchor.constraint(equalToConstant: 32),
            statusImage.heightAnchor.constraint(equalToConstant: 32),
            
            titleAndDescriptionStackView.leadingAnchor.constraint(equalTo: statusImage.trailingAnchor, constant: 16),
            titleAndDescriptionStackView.trailingAnchor.constraint(equalTo: toastContainer.trailingAnchor, constant: -16),
            titleAndDescriptionStackView.topAnchor.constraint(equalTo: toastContainer.topAnchor, constant: 16),
            titleAndDescriptionStackView.bottomAnchor.constraint(equalTo: toastContainer.bottomAnchor, constant: -16),
            
            toastContainer.topAnchor.constraint(equalTo: controller.view.safeAreaLayoutGuide.topAnchor, constant: 16),
            toastContainer.leadingAnchor.constraint(equalTo: controller.view.leadingAnchor, constant: 16),
            toastContainer.trailingAnchor.constraint(equalTo: controller.view.trailingAnchor, constant: -16)
        ])

        UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseIn, animations: {
            toastContainer.alpha = 1.0
        }, completion: { _ in
            UIView.animate(withDuration: 0.5, delay: 1.5, options: .curveEaseOut, animations: {
                toastContainer.alpha = 0.0
            }, completion: {_ in
                toastContainer.removeFromSuperview()
            })
        })
    }
}
