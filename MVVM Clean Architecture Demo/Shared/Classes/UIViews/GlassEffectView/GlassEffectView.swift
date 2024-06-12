//
//  GlassEffectView.swift
//  MVVM Clean Architecture Demo
//
//  Created by Ahmed Abd Elaziz on 05/06/2024.
//

import UIKit

class GlassEffectView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {

        let blurEffect = UIBlurEffect(style: .systemMaterial)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        blurEffectView.alpha = 0.4
        self.addSubview(blurEffectView)
        
        self.sendSubviewToBack(blurEffectView)
        
        self.backgroundColor = UIColor.clear
    }
    
    func addBorder(width: CGFloat, color: CGColor = UIColor.white.cgColor) {
        layer.borderWidth = width
        layer.borderColor = color
    }
    
}
