//
//  SwipeView.swift
//  SwipeFlix
//
//  Created by Daniel Efrain Ocasio on 12/5/23.
//

import Foundation
import UIKit

class DiscoverView: UIView {
	
	let colorManager = ColorManager()
	
	lazy var screenTitle: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.text = "Discover"
		label.textColor = .white
		label.font = UIFont(name: "Comfortaa-Light", size: 25)
		return label
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		backgroundColor = .black
		translatesAutoresizingMaskIntoConstraints = false
		
		addSubview(screenTitle)
		
		NSLayoutConstraint.activate([
			screenTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
			screenTitle.topAnchor.constraint(equalTo: topAnchor, constant: 150)
		])
		
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		
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
