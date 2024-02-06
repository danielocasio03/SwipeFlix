//
//  SearchView.swift
//  SwipeFlix
//
//  Created by Daniel Efrain Ocasio on 12/8/23.
//


import Foundation
import UIKit

class SearchView: UIView {
	
	let colorManager = ColorManager()
	
	lazy var screenTitle: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.text = "Search"
		label.textColor = .white
		label.font = UIFont(name: "Comfortaa-Light", size: 25)
		return label
	}()
	
	lazy var searchBar: UITextField = {
		let textField = UITextField()
		textField.translatesAutoresizingMaskIntoConstraints = false
		textField.backgroundColor = UIColor(red: 239/255, green: 116/255, blue: 92/255, alpha: 0.05)
		textField.font = UIFont(name: "Comfortaa-Light", size: 12)
		textField.textColor = .white
		textField.placeholder = "Search for Movies..."
		textField.layer.cornerRadius = 10
		
		let padding = UIView()
		padding.frame = CGRect(x: 0, y: 0, width: 12, height: 0)
		textField.leftView = (padding)
		textField.leftViewMode = .always
		
		return textField
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		backgroundColor = .black
		translatesAutoresizingMaskIntoConstraints = false
		
		addSubview(screenTitle)
		addSubview(searchBar)
		
		NSLayoutConstraint.activate([
			screenTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
			screenTitle.topAnchor.constraint(equalTo: topAnchor, constant: 150),
			
			searchBar.topAnchor.constraint(equalTo: screenTitle.bottomAnchor, constant: 15),
			searchBar.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 17),
			searchBar.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -17),
			searchBar.heightAnchor.constraint(equalToConstant: 28)
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
