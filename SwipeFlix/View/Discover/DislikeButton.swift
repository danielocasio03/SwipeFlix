//
//  dislikeButton.swift
//  SwipeFlix
//
//  Created by Daniel Efrain Ocasio on 12/15/23.
//

import Foundation
import UIKit

class DislikeButton: UIButton {
	let colorManager = ColorManager()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		//UI Config
		translatesAutoresizingMaskIntoConstraints = false
		layer.cornerRadius = 37.5
		widthAnchor.constraint(equalToConstant: 77).isActive = true
		heightAnchor.constraint(equalToConstant: 77).isActive = true
		clipsToBounds = true
		backgroundColor = .clear
		layer.borderWidth = 0.25
		layer.borderColor = UIColor(red: 15/255, green: 15/255, blue: 15/255, alpha: 1).cgColor
		
		//Button
		tintColor = colorManager.dislikeButtonColor
		let largeConfig = UIImage.SymbolConfiguration(pointSize: 25, weight: .bold, scale: .default)
		let largexMark = UIImage(systemName: "xmark", withConfiguration: largeConfig)
		setImage(largexMark, for: .normal)
		
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		//Gradient
		let gradient = CAGradientLayer()
		gradient.colors = [colorManager.black30.cgColor, colorManager.black10.cgColor]
		gradient.startPoint = CGPoint(x: 0.5, y: 0.3)
		gradient.endPoint = CGPoint(x: 0.5, y: 1.0)
		gradient.frame = self.bounds
		self.layer.insertSublayer(gradient, at: 0)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
