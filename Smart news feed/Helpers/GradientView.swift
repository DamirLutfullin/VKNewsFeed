//
//  GradientView.swift
//  Smart news feed
//
//  Created by Damir Lutfullin on 15.06.2020.
//  Copyright © 2020 DamirLutfullin. All rights reserved.
//

import Foundation
import UIKit

class GradientView: UIView {
    private let gradientLayer = CAGradientLayer()
    @IBInspectable private var startColor: UIColor? {
        didSet {
            setupGradientColors()
        }
    }
    @IBInspectable private var endColor: UIColor? {
        didSet {
            setupGradientColors()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupGradient()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }
    
    private func setupGradient() {
        self.layer.addSublayer(gradientLayer)
        setupGradientColors()
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
    }
    
    private func setupGradientColors() {
        guard let startColor = startColor, let endColor = endColor else { return }
        gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
    }
}
