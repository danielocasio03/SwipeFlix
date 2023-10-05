//
//  HomeView.swift
//  SwipeFlix
//
//  Created by Daniel Efrain Ocasio on 7/24/23.
//

import Foundation
import UIKit


class HomeView: UIView {
	let colorManager = ColorManager()
	
	
	override init(frame: CGRect) {
		super.init(frame: frame)
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		setupView()
	}
	
	
	func setupView() {
		backgroundColor = .black
		translatesAutoresizingMaskIntoConstraints = false
		
		let gradient = CAGradientLayer()
		
		gradient.colors = [colorManager.gradientPink.cgColor, colorManager.gradientPurple.cgColor]
		
		gradient.startPoint = CGPoint(x: 0.5, y: 0.0)
		gradient.endPoint = CGPoint(x: 0.5, y: 1.0)
		
		gradient.frame = self.bounds
		
		self.layer.insertSublayer(gradient, at: 0)
		
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}
